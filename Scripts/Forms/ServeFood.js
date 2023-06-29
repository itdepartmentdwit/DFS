/// <reference path="../_references.js" />
/// <reference path="../Plugins/jquery-blink.js" />
var serveFood = serveFood || {
    Init: function() {
        this.LoadGrids();
    },
    LoadGrids: function() {
        serveFood.AjaxCall.LoadServeGrid();
    },
    BuildServeTable:
    {
        SetTableData: function(data) {
            var jsonData = $.parseJSON(data.d)

            $('#_containerReadyOrders').html(serveFood.BuildServeTable.GetReadyOrdersTable(jsonData[0], '#_containerReadyOrders'));

            var contentHeight = $('#content').height();
            var contReadyHeight = $('#_containerReadyOrders').height();
            var contOnProcessHeight = contentHeight - contReadyHeight;
            $('#_containerOnProcessOrders').css("height", contOnProcessHeight);

            $('#_containerServeLeft').html(serveFood.BuildServeTable.GetTable(jsonData[1], '#_containerServeLeft', 'LeftTable'));
            $('#_containerServeRight').html(serveFood.BuildServeTable.GetTable(jsonData[2], '#_containerServeRight', 'RightTable'));
        },
        GetTable: function(data, container, tableID) {
            if (typeof data !== 'undefined') //&& data.length > 0
            {
                //var table = '<table class="new_table" border="1"><thead><tr><th style="width:140px;">Time</th><th style="width:140px;">Elasped Time</th><th style="width:140px;" >Customer ID</th><th>Item</th><th style="width:120px;">Quantity</th></thead><tbody>';
                var table = '<table class="new_table" border="1" id=\'' + tableID + '\'>';
                var css = '';
                var row = null;
                if (data.length > 0) {

                    var noOfAvailRec = 0;
                    for (var record in data) {
                        noOfAvailRec += 1;

                        if (!data[record].IsReady && data[record].DeliveryLate) {
                            css = 'highlight';
                        } else if (data[record].IsReady)
                            css = 'isReady';
                        else
                            css = '';
                        row = '<tr class=' + css + '>';
                        row += '<td style="width:70px;"  class="textfill"><span class="nowrap">' + data[record].ElaspedTime + ' m' + '</span></td>';
                        row += '<td style="width:60px;" class="textfill"><span>' + data[record].UserId + '</span></td>';
                        row += '<td  class="textfill"><span>' + data[record].FoodName + '</span></td>';
                        row += '</tr>';
                        table += row;
                    }

                    var remainingEmptyRows = 13 - noOfAvailRec;

                    for (var i = 1; i <= remainingEmptyRows; i++) {

                        row = '<tr>';
                        row += '<td>&nbsp;</td>';
                        row += '<td>&nbsp;</td>';
                        row += '<td>&nbsp;</td>';
                        row += '</tr>';
                        table += row;
                    }

                } else {
                    row = '<tr>';
                    row += '<td colspan="3" align="Center" class="textfill"><span class="info" >Records not found.<span></td>';
                    row += '</tr>';
                    table += row;
                }

                //table += '</tbody></table>';
                table += '</table>';

                $(container).html(table);
                $('.textfill').textfill();
            } else {
                $(container).html('');
            }
        },
        GetReadyOrdersTable: function(data, container) {

            if (typeof data !== 'undefined') {
                var readyOrders = '';

                if (data.length > 0) {

                    for (var record in data) {

                        readyOrders += '<div>' + data[record] + '</div>';
                    }
                }

                $(container).html(readyOrders);
            } else {

                $(container).html('');

            }
        }
    },

    BuildQueueTable:
    {
        SetTableData: function(data) {
            var jsonData = $.parseJSON(data.d)

            $('#_containerQueueLeft').html(serveFood.BuildQueueTable.GetTable(jsonData[0], '#_containerQueueLeft'));
            $('#_containerQueueRight').html(serveFood.BuildQueueTable.GetTable(jsonData[1], '#_containerQueueRight'));
        },
        GetTable: function(list, container) {
            var table = '<table class="new_table" border="1"><thead><tr><th>Item</th><th>Quantity</th></thead><tbody>';
            if (typeof list !== 'undefined') //&& list.length > 0
            {
                $('span#_noQueue').hide();
                var row = null;
                if (list.length > 0) {
                    for (var record in list) {
                        row = '<tr>';
                        row += '<td>' + list[record].FoodName + '</td>';
                        row += '<td>' + list[record].Quantity + '</td>';
                        row += '</tr>';
                        table += row;
                    }
                } else {

                    row = '<tr>';
                    row += '<td colspan="2" style="background-color:#f7e9d9;border:1px solid #F48E51;"><span class="info" >Records not found.<span></td>';
                    row += '</tr>';
                    table += row;
                }
                table += '</tbody></table>';
                return table;

            } else {
                $('span#_noQueue').show();
                $(container).html(table);
            }
        }
    },
    AjaxCall:
    {
        LoadServeGrid: function() {
            $.ajax({
                url: "ServeFood.aspx/GetTableDataForFoodServe",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: {},
                responseType: "json",
                type: 'POST',
                success: function(data) {
                    serveFood.BuildServeTable.SetTableData(data);
                },
                error: function(x, y, z) {
                    console.log(x);
                    console.log(y);
                    console.log(z);
                }
            });
        },
        LoadQueueGrid: function() {
            $.ajax({
                url: "ServeFood.aspx/GetTableDataForFoodQueue",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: {},
                responseType: "json",
                type: 'POST',
                success: function(data) {
                    serveFood.BuildQueueTable.SetTableData(data);
                },
                error: function(x, y, z) {
                    console.log(x);
                    console.log(y);
                    console.log(z);
                }
            });
        }
    }
}