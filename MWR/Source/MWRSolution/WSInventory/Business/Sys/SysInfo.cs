﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using YRKJ.MWR.WinBase.WinAppBase.Config;

namespace YRKJ.MWR.WSInventory.Business.Sys
{
    public class SysInfo
    {
        public const string Broadcast_RecoverTxnCount = "RecoverTxnCount";

        public const int SystemVersion = 1;
        public TblMWEmploy Employ = null;
        public AppConfig Config = null;

        private static SysInfo _sysInfo = null;
        public static SysInfo GetInstance()
        {
            if (_sysInfo == null)
            {
                _sysInfo = new SysInfo();
            }
            return _sysInfo;
        }
    }
}
