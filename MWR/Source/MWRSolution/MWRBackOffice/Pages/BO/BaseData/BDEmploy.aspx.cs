﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YRKJ.MWR.Business.BaseData;
using YRKJ.MWR.Business;
using YRKJ.MWR.Business.Permit;
using YRKJ.MWR.BackOffice.Business.Sys;
using ComLib.db;

namespace YRKJ.MWR.BackOffice.Pages.BO.BaseData
{
    public partial class BDEmploy : BasePage
    {
        public const string ClassName = "YRKJ.MWR.BackOffice.Pages.BO.BaseData.BDEmploy";

        private int pageSize = 3;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string errMsg = "";
                if (!InitPage(ref errMsg))
                {
                    // do error thing
                }
            }
        }

        #region Events

        public bool AjaxSubEmpy(string empyCode,string password, string empyName, string empyType,
            string opyEmpyCode, string opyType, string page)
        {
            string errMsg = "";

            if (opyType.ToLower().Equals("new"))
            {
                TblMWEmploy empy = new TblMWEmploy();
                empy.EmpyCode = empyCode;
                empy.EmpyName = empyName;
                empy.Password = password;
                empy.EmpyType = empyType;
                empy.Status = TblMWEmploy.STATUS_ENUM_Active;
                if (!PermitMng.AddNewEmploy(empy, ref errMsg))
                {
                    ReturnAjaxError(errMsg);
                    return false;
                }
            }
            else if (opyType.ToLower().Equals("edit"))
            {
                if (!PermitMng.ChangeEmpyInfo(empyCode, empyName, empyType, ref errMsg))
                {
                    ReturnAjaxError(errMsg);
                    return false;
                }
            }
            else
            {
                if (!AjaxSubEmpy_OptEvent(opyEmpyCode, opyType, ref errMsg))
                {
                    ReturnAjaxError(errMsg);
                    return false;
                }
            }
            

            int CurrentPage = ComLib.ComFn.StringToInt(page);
            
            if (!LoadData_EmpyData(CurrentPage, ref errMsg))
            {
                ReturnAjaxError(errMsg);
                return false;
            }
            return true;
        }

        public bool AjaxSubEmpy(string opyEmpyCode, string opyType, string page)
        {
            string errMsg = "";
            if (!AjaxSubEmpy_OptEvent(opyEmpyCode,opyType,ref errMsg))
            {
                ReturnAjaxError(errMsg);
                return false;
            }

            int CurrentPage = ComLib.ComFn.StringToInt(page);

            if (!LoadData_EmpyData(CurrentPage, ref errMsg))
            {
                ReturnAjaxError(errMsg);
                return false;
            }
            return true;
        }

        public bool AjaxSubEmpy_OptEvent(string empyCode, string opyType, ref string errMsg)
        {
            if (opyType.ToLower().Equals("void"))
            {
                if (!PermitMng.VoidEmploy(empyCode, ref errMsg))
                {
                    return false;
                }
            }
            else if (opyType.ToLower().Equals("active"))
            {
                if (!PermitMng.ActiveEmploy(empyCode, ref errMsg))
                {
                    return false;
                }
            }
            return true;
        }
      
        #endregion

        #region Functions

        private bool InitPage(ref string errMsg)
        {
            if (!LoadData(ref errMsg))
            {
                return false;
            }

            return true;
        }
       
        private bool LoadData(ref string errMsg)
        {
            int page = 1;
            if (!LoadData_EmpyData(page, ref errMsg))
            {
                return false;
            }

            return true;
        }

        private bool LoadData_EmpyData(int page, ref string errMsg)
        {
            List<VewEmployWithFunctionGroup> empyList = null;
            long pageCount = 0;
            long rowCount = 0;
            if (!BaseDataMng.GetEmpyWithFuncGroupDataList(page, pageSize, ref pageCount,ref rowCount, ref empyList, ref errMsg))
            {
                return false;
            }

            c_UPage.ShowPage(page, (int)pageCount);
            foreach (var item in empyList)
            {
                PageEmployDataList.Add(new PageEmployData()
                {
                    EmpyCode = item.EmpyCode,
                    EmpyName = item.EmpyName,
                    EmpyPassword = SqlCommonFn.DecryptString(item.Password),
                    EmpyType = BizHelper.GetEmpyType(item.EmpyType),
                    FuncGroup = item.FuncGroupId < 0 ? PermitMng.GetSysDefaultFuncGroupName(item.FuncGroupId) : item.FuncGroupName,
                    IsActive = item.Status.Equals(TblMWEmploy.STATUS_ENUM_Void) ? false : true
                });
            }

            return true;
        }

        #endregion

        #region PageDatas
        protected List<PageEmployData> PageEmployDataList = new List<PageEmployData>();
        #endregion

        #region Common
        private class LngRes
        {
            public const string MSG_FormName = "";
        }

        protected class PageEmployData
        {
            public string EmpyCode { get; set; }
            public string EmpyName { get; set; }
            public string EmpyPassword { get; set; }
            public string FuncGroup { get; set; }
            public string EmpyType { get; set; }
            public bool IsActive { get; set; }
           
        }
        #endregion
    }
}