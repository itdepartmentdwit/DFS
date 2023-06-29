using DFS.Common;
using DFS.Core.ViewModels;
using DFS.Core.Services;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web.Script.Services;
using System.Web.Services;
using DFS.Web.Common;

namespace DFS.Web.WebService
{
    /// <summary>
    /// Summary description for WebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class WebService : System.Web.Services.WebService
    {
        private FoodOrderService _foodOrderRepo { get; set; }

        public WebService()
        {
            var constr = DatabaseManager.GetConnectionString();
            _foodOrderRepo = new FoodOrderService(constr);
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string GetTableDataForFoodServe()
        {
            Tuple<List<int>, List<ServeItemViewModel>> tupOrders =
                _foodOrderRepo.GetServedFoodOrdersForServeScreen(DateTime.Now);
                // Added By: Randhir Yadav on May 9, 2014
            List<int> lstReadyOrders = tupOrders.Item1;
            List<ServeItemViewModel> lstOnProcessOrders = tupOrders.Item2;

            var firstGridRecords = lstOnProcessOrders.Take(13).ToList();
            var secondGridRecords = lstOnProcessOrders.Skip(13).Take(13).ToList();

            ArrayList alOrders = new ArrayList();
            alOrders.Add(lstReadyOrders);
            alOrders.Add(firstGridRecords);
            alOrders.Add(secondGridRecords);

            return JsonHelper.JsonSerializer(alOrders);
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string GetTableDataForFoodQueue()
        {
            var records = _foodOrderRepo.GetQuedFoodOrders();

            int initialRecords = Convert.ToInt32(Math.Ceiling((double) records.Count/2));

            var recForFirstQueue = records.Take(initialRecords).ToList();
            var recForSecondQueue = records.Except(recForFirstQueue).ToList();
            List<List<ServeItemViewModel>> Coll = new List<List<ServeItemViewModel>>();
            Coll.Add(recForFirstQueue);
            Coll.Add(recForSecondQueue);

            return JsonHelper.JsonSerializer(Coll);
        }
    }
}