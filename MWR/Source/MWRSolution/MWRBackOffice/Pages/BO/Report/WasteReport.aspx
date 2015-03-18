﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/MasterPages/MWBOEmpty.Master" AutoEventWireup="true" CodeBehind="WasteReport.aspx.cs" Inherits="YRKJ.MWR.BackOffice.Pages.BO.Report.WasteReport" %>
<%@ Import Namespace="YRKJ.MWR" %>
<%@ Import Namespace="YRKJ.MWR.BackOffice.Business.Sys" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link rel="stylesheet" type="text/css" href="/assets/plugins/select2/select2_metro.css"/>
<link rel="stylesheet" href="/assets/plugins/data-tables/DT_bootstrap.css"/>
<link href="/assets/css/pages/profile.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
<div class="row">
	<div class="col-md-12">
		<h3 class="page-title">
		医疗废品库存详情 <small>查看医疗废品库存详情</small>
		</h3>
		<ul class="page-breadcrumb breadcrumb">
			<li class="btn-group">
			</li>
			<li>
				<i class="fa fa-home"></i>
				<a href="#<% = RedirectHelper.BOMain %>">主页</a>
				<i class="fa fa-angle-right"></i>
			</li>
			<li>
				<i class="fa fa-home"></i>
                <a href="#<% = RedirectHelper.IntegratedReport %>">综合报告</a>
                <i class="fa fa-angle-right"></i>
			</li>
            <li>
				医疗废品库存详情
			</li>
		</ul>
	</div>
</div>

<div class=" row portfolio-block note note-info">
		<div class="col-md-3 ">
			<div class="portfolio-text ">
				<div class="portfolio-info">
					<h4><% = PageWasteNameData%>-统计信息</h4>
					<p>
						<% = PageWasteNameData%>-重量信息
					</p>
				</div>
			</div>
		</div>
		<div class="col-md-8 portfolio-stat " >
			<div class="portfolio-info">
					回收总重量
				<span>
					<% = PageInventoryVendorReportData.RecoWeight%> KG
				</span>
			</div>
			<div class="portfolio-info">
					库存总重量
				<span>
					<% = PageInventoryVendorReportData.InvWeight%> KG
				</span>
			</div>
			<div class="portfolio-info">
					处置总重量
				<span>
					<% = PageInventoryVendorReportData.DestWeight%> KG
				</span>
			</div>
		</div>
	</div>


<div class="row">
    <div class="col-md-12">
	    <!-- BEGIN EXAMPLE TABLE PORTLET-->
	    <div class="portlet box green">
		    <div class="portlet-title">
			    <div class="caption">
				    <i class="fa fa-globe"></i><% = PageWasteNameData%>-库存废品列表
			    </div>
			    <div class="tools">
				    <a href="javascript:;" class="reload"></a>
				    <a href="javascript:;" class="remove"></a>
			    </div>
		    </div>
		    <div class="portlet-body">
			    <table class="table table-striped table-bordered table-hover" id="sample_1">
			    <thead>
			    <tr>
				    <th>
					    货箱编号
				    </th>
				    <th>
					    仓库编号
				    </th>
				    <th>
					    医疗机构
				    </th>
				    <th>
					    回收重量
				    </th>
				    <th>
					    入库重量
				    </th>
                    <th>
					    处置重量
				    </th>
                    <th>
					    状态
				    </th>
			    </tr>
			    </thead>
			    <tbody>
                    <%
                        foreach (var item in PageInventoryDataList)
	{
                    %>
			    <tr>
				    <td>
					    <% = item.CrateCode %>
                        <input class="mw-invRecodId" type="hidden" value="<% = item.InvRecordId %>" />
				    </td>
				    <td>
					    <% = item.DepotCode %>
				    </td>
				    <td>
					    <% = item.Vendor %>
				    </td>
				    <td>
					    <% = item.RecoWeight %>
				    </td>
				    <td>
					    <% = item.InvWeight %>
				    </td>
                    <td>
					    <% = item.DestWeight %>
				    </td>
                    <td>
					    <% = YRKJ.MWR.Business.BizHelper.GetInventoryStatus(item.Status)%>
				    </td>
			    </tr>
                <%
	}
                    %>
			        </tbody>
			    </table>
		    </div>
	    </div>
	    <!-- END EXAMPLE TABLE PORTLET-->
	   
    </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="foot" runat="server">
<script type="text/javascript" src="/assets/plugins/select2/select2.min.js"></script>
<script type="text/javascript" src="/assets/plugins/data-tables/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="/assets/plugins/data-tables/DT_bootstrap.js"></script>
<script src="/assets/bovendorreport.js"></script>
<script>
    jQuery(document).ready(function () {
        VendorReport.init();
    });
</script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footscript" runat="server">
</asp:Content>