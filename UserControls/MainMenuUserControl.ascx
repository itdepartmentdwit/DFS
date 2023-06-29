<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MainMenuUserControl.ascx.cs" Inherits="DFS.Web.UserControls.MainMenuUserControl" %>
<div class="menu">
    <ul>
          <% if(!HttpContext.Current.User.IsInRole(DFS.Common.UserType.RestaurantOperator))
           { %>
        <li><a href="http://deerwalkfoods.com" target="_blank">DEERWALK FOODS</a></li>

        <li><a href='<%= ResolveUrl("~/Feedback.aspx") %>'>FEEDBACK</a></li>
           <% }  %>

                  <% if(HttpContext.Current.User.IsInRole(DFS.Common.UserType.RestaurantOperator) || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSAdmin))
           { %>
         <li><a href="#" class="nolink">Coupon Transaction<!--[if gte IE 7]><!--></a><!--<![endif]-->
              <ul>
          <li><a href='<%= ResolveUrl("~/Manage/CouponTransaction.aspx") %>'> Transaction</a></li>
          <li><a href='<%= ResolveUrl("~/CouponTransactionHistory.aspx") %>'> Transaction History</a></li>
                  </ul>
             </li>

         <% }  %>
        <% if (HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSAdmin)
               || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DSSAdmin)
               || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DSSStudent))
           { %>
        <li><a href="#" class="nolink">DSS STUDENT DEPOSIT<!--[if gte IE 7]><!--></a><!--<![endif]-->
            <!--[if lte IE 6]><table><tr><td><![endif]-->
            <ul>
                <% if ((HttpContext.Current.User.IsInRole(DFS.Common.UserType.DSSStudent) ||
                            HttpContext.Current.User.IsInRole(DFS.Common.UserType.DSSAdmin)
                            || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSAdmin)))
                   { %>
                <li><a href='<%= ResolveUrl("~/StudentDeposit/UserDeposit.aspx") %>'>Deposit History</a></li>

                <% }
                   if (HttpContext.Current.User.IsInRole(DFS.Common.UserType.DSSAdmin)
                       || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSAdmin))
                   { %>
                <li><a href='<%= ResolveUrl("~/StudentDeposit/StudentBalance.aspx") %>'>Student Balance</a></li>

                <% }

                       if (HttpContext.Current.User.IsInRole(DFS.Common.UserType.DSSAdmin)
                           || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSAdmin)
                           || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DSSStudent))
                       { %>
                <li><a href='<%= ResolveUrl("~/StudentDeposit/Transactions.aspx") %>'>Transactions</a></li>

                <% }
                %>
            </ul>
            <!--[if lte IE 6]></td></tr></table></a><![endif]-->
        </li>
        <% }
        %>

        <% if (HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSAdmin)
               || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWITAdmin)
               || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWITStudent))
           { %>
        <li><a href="#" class="nolink">STUDENT DEPOSIT<!--[if gte IE 7]><!--></a><!--<![endif]-->
            <!--[if lte IE 6]><table><tr><td><![endif]-->
            <ul>
                <% if ((HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWITStudent) ||
                            HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWITAdmin)
                            || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSAdmin)))
                   { %>
                <li><a href='<%= ResolveUrl("~/Deposit/UserDeposit.aspx") %>'>Deposit History</a></li>

                <% }
                   if (HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWITAdmin)
                       || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSAdmin))
                   { %>
                <li><a href='<%= ResolveUrl("~/Deposit/StudentBalance.aspx") %>'>Student Balance</a></li>

                <% }

                       if (HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWITAdmin)
                           || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSAdmin)
                           || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWITStudent))
                       { %>
                <li><a href='<%= ResolveUrl("~/Deposit/Transactions.aspx") %>'>Transactions</a></li>

                <% }
                %>
            </ul>
            <!--[if lte IE 6]></td></tr></table></a><![endif]-->
        </li>
        <% }
        %>

        <% if (HttpContext.Current.User.IsInRole(DFS.Common.UserType.DFSManager) || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DFSOperator))
           { %>
        <li><a class="nolink">FOOD MANAGEMENT<!--[if gte IE 7]><!--></a><!--<![endif]-->
            <!--[if lte IE 6]><table><tr><td><![endif]-->
            <ul>
                <% if (HttpContext.Current.User.IsInRole(DFS.Common.UserType.DFSManager) || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DFSOperator))
                   { %>
                <li><a href='<%= ResolveUrl("~/Manage/CanteenManager.aspx") %>'>Process Orders</a></li>                
                <li><a href='<%= ResolveUrl("~/Manage/MissedOrders.aspx") %>'>Process Missed Orders</a></li>
                <% }
                %>
                           

                <% if (HttpContext.Current.User.IsInRole(DFS.Common.UserType.DFSManager))
                   { %>                                                
                        <li><a href='<%= ResolveUrl("~/Manage/GenerateMenu.aspx") %>'>Generate Menu</a></li>
                        <li><a href='<%= ResolveUrl("~/Manage/FoodManager.aspx") %>'>Add/Edit Food</a></li>
                        <li><a href='<%= ResolveUrl("~/Manage/CategoryManager.aspx") %>'>Add/Edit Category</a></li>
                        <li><a href='<%= ResolveUrl("~/Manage/HotDrinksRate.aspx") %>'>Hot Drinks Rate</a></li>
                        <li><a href='<%= ResolveUrl("~/Manage/HotDrinksIntake.aspx") %>'>Daily Hot Drinks Intake</a></li>
                        <li><a href='<%= ResolveUrl("~/Manage/ServeFood.aspx") %>'>Serve Food</a></li>
                <% }
                %>
                <% if (HttpContext.Current.User.IsInRole(DFS.Common.UserType.DFSManager) || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DFSOperator))
                   { %>
                <li><a href='<%= ResolveUrl("~/Manage/OrderSummary.aspx") %>'>Order Summary</a></li>
                <li><a href='<%= ResolveUrl("~/Manage/ResetServeFoods.aspx") %>'>Reset Food Orders</a></li>
                <% }
                %>
            </ul>
            <!--[if lte IE 6]></td></tr></table></a><![endif]-->
        </li>
        <% }
        %>
          
        <li><a class="nolink">REPORTS<!--[if gte IE 7]><!--></a><!--<![endif]-->
            <!--[if lte IE 6]><table><tr><td><![endif]-->
            <ul>
                <%
                    if (HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSAdmin)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSGuest)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSStaff)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSUnpaidIntern)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWITAdmin)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWITStaff)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWITGuest)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWITStudent)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DSSStudent)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWTTAdmin)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWTTStaff)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWTTGuest)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DCAdmin)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DCGuest)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DCStaff)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DSSStaff)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DSSAdmin)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.KPStaff)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.KPAdmin)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWCStaff)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWCAdmin)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWITFaculty)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWITFaculty)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DeerHoldStaff)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DeerHoldAdmin)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.SmartIdeasStaff)
                        || HttpContext.Current.User.IsInRole(DFS.Common.UserType.SmartIdeasAdmin))
                    { %>

                <li><a href='<%= ResolveUrl("~/Report/ExpenseReport.aspx") %>'>Expense Report</a></li>
                
                <%--<% if (HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSAdmin)|| HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSStaff) || (HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWITStudent) && AppUserService.GetUser(UserID) Membership.GetUser(this.Context.User.Identity.Name).DWITStudentDetails.IsIntern==true ))--%>
                <% if (HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSAdmin)|| HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSStaff) || (HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWITStudent) && Session["IsStudentIntern"] != null ))
                  
                        { %>
                <li><a href='<%= ResolveUrl("~/Report/109CouponEmployeReport.aspx") %>'>My Coupon List</a></li>
                 <li><a href='<%= ResolveUrl("~/Report/MyCouponUsageReport.aspx") %>'>My Coupon Usage Report</a></li>
                 <% } %>
                <%
                    } %>


                <% if (HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSAdmin)|| HttpContext.Current.User.IsInRole(DFS.Common.UserType.RestaurantOperator))
                   { %>
                <li><a href='<%= ResolveUrl("~/Report/109CouponUsageReport.aspx") %>'>Automated Coupon Usage Report</a></li>
                <% } %>

                <% if (HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSAdmin))
                   { %>
                <li><a href='<%= ResolveUrl("~/Report/DinnerExpenseReport.aspx") %>'>Dinner Expense Report</a></li>
                <% } %>

                <% if (HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSAdmin) || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DFSManager) || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DFSOperator))
                   { %>
                <li><a href='<%= ResolveUrl("~/Report/FreeFoodReport.aspx") %>'>Free Food Report</a></li>
                <li><a href='<%= ResolveUrl("~/Report/109CouponsTotalReport.aspx") %>'> Old 109 Coupons Report</a></li>
                <li><a href='<%= ResolveUrl("~/Report/DinnerReport.aspx") %>'>Dinner Report</a></li>
                <li><a href='<%= ResolveUrl("~/Report/HotDrinksReport.aspx") %>'>Hot Drinks Report</a></li>
                <li><a href='<%= ResolveUrl("~/Report/ColdDrinksReport.aspx") %>'>Cold Drinks Report</a></li>
                <li><a href='<%= ResolveUrl("~/Report/SalesReport.aspx") %>'>Sales Report</a></li>
                <li><a href='<%= ResolveUrl("~/Report/BreakfastExpensesReport.aspx") %>'>Breakfast Expenses Report</a></li>
                <li><a href='<%= ResolveUrl("~/Report/DeliveredItemsReport.aspx") %>'>Delivered Food Items Report</a></li>
                <% }
                %>
            </ul>
            <!--[if lte IE 6]></td></tr></table></a><![endif]-->
        </li>

        <% if (HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSAdmin) || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWITAdmin) || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWTTAdmin)
               || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DCAdmin) || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DSSAdmin) || HttpContext.Current.User.IsInRole(DFS.Common.UserType.KPAdmin) || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWCAdmin) || HttpContext.Current.User.IsInRole(DFS.Common.UserType.DeerHoldAdmin)|| HttpContext.Current.User.IsInRole(DFS.Common.UserType.SmartIdeasAdmin))
           { %>
        <li><a class="nolink">ADMINISTRATION<!--[if gte IE 7]><!--></a><!--<![endif]-->
            <!--[if lte IE 6]><table><tr><td><![endif]-->
            <ul>
                <li><a href='<%= ResolveUrl("~/Admin/UserManagement.aspx") %>'>User Management</a></li>
                <%
               if (HttpContext.Current.User.IsInRole(DFS.Common.UserType.DWSAdmin))
               { %>
                <li><a href='<%= ResolveUrl("~/Admin/Notifications.aspx") %>'>Notifications</a></li>
                <li><a href='<%= ResolveUrl("~/Admin/Holiday.aspx") %>'>Holiday Setting</a></li>
                <li><a href='<%= ResolveUrl("~/Admin/NepaliMonthSetting.aspx") %>'>Nepali Date Setting</a></li>
                <% }
                %>
            </ul>
            <!--[if lte IE 6]></td></tr></table></a><![endif]-->
        </li>
        <% } %>
        <li><a class="nolink">MY ACCOUNT<!--[if gte IE 7]><!--></a><!--<![endif]-->
            <!--[if lte IE 6]><table><tr><td><![endif]-->
            <ul>
                <li><a href='<%= ResolveUrl("~/ChangePassword.aspx") %>'>Change Password</a></li>
                <li>
                    <asp:LinkButton ID="lnkLogOut" runat="server" OnClick="LogOut" CausesValidation="false">Sign out</asp:LinkButton></li>
            </ul>
            <!--[if lte IE 6]></td></tr></table></a><![endif]-->
        </li>
    </ul>
</div>
<%--
    Please do not delete this original reference to menu. This is a complete html reference for this menu.
    http://www.cssplay.co.uk/menus/final_drop.html
    <div class="menu">
    <ul>
        <li><a href="../menu/index.html">DEMOS<!--[if gte IE 7]><!--></a><!--<![endif]-->
            <!--[if lte IE 6]><table><tr><td><![endif]-->
            <ul>
                <li><a href="../menu/zero_dollars.html">zero dollars advertising page</a></li>
                <li><a href="../menu/embed.html">wrapping text around images</a></li>
                <li><a href="../menu/form.html">styled form</a></li>
                <li><a href="../menu/nodots.html">active focus</a></li>
                <li><a href="../menu/hover_click.html" class="drop">hover/click with no borders<!--[if gte IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                    <ul>
                        <li><a href="../menu/form.html">styled form</a></li>
                        <li><a href="../menu/nodots.html">removing active/focus borders</a></li>
                        <li><a href="../menu/hover_click.html">hover/click</a></li>
                    </ul>
                    <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                </li>
                <li><a href="../menu/shadow_boxing.html" class="drop">shadow boxing<!--[if gte IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                    <ul>
                        <li><a href="../menu/form.html">styled form</a></li>
                        <li><a href="../menu/nodots.html">removing active/focus borders</a></li>
                        <li><a href="../menu/hover_click.html">hover/click</a></li>
                    </ul>
                    <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                </li>
                <li><a href="../menu/old_master.html" class="drop">image map for detailed information<!--[if gte IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                    <ul>
                        <li><a href="../menu/form.html">styled form</a></li>
                        <li><a href="../menu/nodots.html">removing active/focus borders</a></li>
                        <li><a href="../menu/hover_click.html">hover/click</a></li>
                    </ul>
                    <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                </li>
                <li><a href="../menu/bodies.html">fun with background images</a></li>
                <li><a href="../menu/fade_scroll.html">fade scrolling</a></li>
                <li><a href="../menu/em_images.html">em image sizes compared</a></li>
            </ul>
            <!--[if lte IE 6]></td></tr></table></a><![endif]-->
        </li>
        <li><a href="../boxes/index.html">BOXES<!--[if gte IE 7]><!--></a><!--<![endif]-->
            <!--[if lte IE 6]><table><tr><td><![endif]-->
            <ul>
                <li><a href="spies.html">a coded list of spies</a></li>
                <li><a href="vertical.html">vertical menu</a></li>
                <li><a href="expand.html">enlarging unordered list</a></li>
                <li><a href="enlarge.html">link images</a></li>
                <li><a href="cross.html">non-rectangular</a></li>
                <li><a href="jigsaw.html">jigsaw links</a></li>
                <li><a href="circles.html">circular links</a></li>
            </ul>
            <!--[if lte IE 6]></td></tr></table></a><![endif]-->
        </li>
        <li><a href="../mozilla/index.html">MOZILLA<!--[if gte IE 7]><!--></a><!--<![endif]-->
            <!--[if lte IE 6]><table><tr><td><![endif]-->
            <ul>
                <li><a href="../mozilla/dropdown.html">drop down menu</a></li>
                <li><a href="../mozilla/cascade.html">cascading menu</a></li>
                <li><a href="../mozilla/content.html">content:</a></li>
                <li><a href="../mozilla/moxbox.html">mozzie box</a></li>
                <li><a href="../mozilla/rainbow.html">I can build a rainbow with transparent borders</a></li>
                <li><a href="../mozilla/snooker.html">a snooker cue using border art</a></li>
                <li><a href="../mozilla/target.html">target practise</a></li>
                <li><a href="../mozilla/splittext.html">two tone headings</a></li>
                <li><a href="../mozilla/shadow_text.html">shadow text</a></li>
            </ul>
            <!--[if lte IE 6]></td></tr></table></a><![endif]-->
        </li>
        <li><a href="../ie/index.html">EXPLORER</a></li>
        <li><a href="../opacity/index.html">OPACITY<!--[if gte IE 7]><!--></a><!--<![endif]-->
            <!--[if lte IE 6]><table><tr><td><![endif]-->
            <ul>
                <li><a href="../opacity/colours.html">a colour wheel using opaque colours</a></li>
                <li><a href="../opacity/picturemenu.html">a menu using opacity</a></li>
                <li><a href="../opacity/png.html">partial opacity</a></li>
                <li><a href="../opacity/png2.html">partial opacity II</a></li>
                <li><a href="../menu/hover_click.html" class="drop">HOVER/CLICK<!--[if gte IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                    <ul class="left">
                        <li><a href="../menu/form.html">styled form</a></li>
                        <li><a href="../menu/nodots.html">removing active/focus borders</a></li>
                        <li><a href="../menu/hover_click.html">hover/click</a></li>
                    </ul>
                    <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                </li>
            </ul>
            <!--[if lte IE 6]></td></tr></table></a><![endif]-->
        </li>
    </ul>
</div>--%>