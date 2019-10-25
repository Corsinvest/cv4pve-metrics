/*
 * This file is part of the cv4pve-metrics https://github.com/Corsinvest/cv4pve-metrics,
 *
 * This source file is available under two different licenses:
 * - GNU General Public License version 3 (GPLv3)
 * - Corsinvest Enterprise License (CEL)
 * Full copyright and license information is available in
 * LICENSE.md which is distributed with this source code.
 *
 * Copyright (C) 2016 Corsinvest Srl	GPLv3 and CEL
 */

using System;
using System.Collections.Generic;
using System.Linq;
using Corsinvest.ProxmoxVE.Api.Extension.Helpers;
using Corsinvest.ProxmoxVE.Api.Extension.Helpers.Shell;
using Corsinvest.ProxmoxVE.Api.Extension.Node;
using InfluxDB.LineProtocol.Client;
using InfluxDB.LineProtocol.Payload;
using McMaster.Extensions.CommandLineUtils;

namespace Corsinvest.Proxmox.Metrics
{
    class Program
    {
        public static readonly string APP_NAME = "cv4pve-metrics";
        static int Main(string[] args)
        {
            var app = ShellHelper.CreateConsoleApp(APP_NAME, "Metrics for Proxmox VE", true);

            var optUrlInfluxDB = app.Option("--influxdb-url",
                                            "InfluxDB url es. http://my-server:8086",
                                            CommandOptionType.SingleValue).IsRequired();

            var optDblInfluxDB = app.Option("--influxdb-db",
                                            "InfluxDB db es. proxmox",
                                            CommandOptionType.SingleValue).IsRequired();

            var optUserInfluxDB = app.Option("--influxdb-user",
                                             "InfluxDB db username",
                                             CommandOptionType.SingleValue);

            var optPasswordInfluxDB = app.Option("--influxdb-password",
                                                 "InfluxDB db password",
                                                 CommandOptionType.SingleValue);

            app.OnExecuteAsync(async cancellationToken =>
            {
                //open connection InfluxDB
                var influxDBClient = new LineProtocolClient(new Uri(optUrlInfluxDB.Value()),
                                                            optDblInfluxDB.Value(),
                                                            optUserInfluxDB.HasValue() ? optUserInfluxDB.Value() : null,
                                                            optPasswordInfluxDB.HasValue() ? optPasswordInfluxDB.Value() : null);

                //open connection proxmox
                var pveClient = app.ClientTryLogin();
                var payload = new LineProtocolPayload();

                //loop nodes online
                foreach (var node in pveClient.GetNodes().Where(a => a.IsOnline))
                {
                    //get tasks
                    foreach (dynamic task in pveClient.Nodes[node.Node].Tasks.NodeTasks(start: 0, limit: 500).Response.data)
                    {
                        var point = new LineProtocolPoint(
                                       "task",
                                       new Dictionary<string, object>
                                       {
                                            {"id", task.id},
                                            {"pid", task.pid},
                                            {"isOk", task.status == "OK"},
                                            {"starttime", DateTimeUnixHelper.UnixTimeToDateTime((long)task.starttime)},
                                            {"endTime", DateTimeUnixHelper.UnixTimeToDateTime(
                                                            (long)DynamicHelper.GetValue(task, "endtime", (long)task.starttime))},
                                            {"type", task.type},
                                            {"status", task.status},
                                            {"upid", task.upid},
                                            {"node", task.node},
                                       },
                                       new Dictionary<string, string>
                                       {
                                            {"type", task.type},
                                           {"status", task.status},
                                            {"upid", task.upid},
                                            {"node", task.node},
                                            {"user", task.user},
                                       },
                                       DateTimeUnixHelper.UnixTimeToDateTime((long)task.starttime));

                        payload.Add(point);
                    }
                }

                try
                {
                    var influxResult = await influxDBClient.WriteAsync(payload, cancellationToken);
                    if (!influxResult.Success)
                    {
                        Console.Error.WriteLine(influxResult.ErrorMessage);
                    }
                }
                catch (Exception ex)
                {
                    Console.Error.WriteLine(ex.Message);
                }

                return 1;
            });

            return app.ExecuteConsoleApp(Console.Out, args);
        }
    }
}