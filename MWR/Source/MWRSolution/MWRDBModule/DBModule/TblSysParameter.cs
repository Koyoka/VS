using System;
using System.Collections.Generic;
using System.Text;
using ComLib.db;

namespace YRKJ.MWR
{

    public class TblSysParameter : BaseDataModule
    {

        private static string TableName = "SysParameter";
        public TblSysParameter()
        {
        }
        public static string getFormatTableName()
        {
            return SqlCommonFn.FormatSqlTableNameString(TableName);
        }

        public static DataColumnInfo[] Columns = 
                new DataColumnInfo[]{
            new DataColumnInfo(true,false,false,false,"ParameterName",SqlCommonFn.DataColumnType.STRING,128),
            new DataColumnInfo(false,true,false,false,"ParameterValue",SqlCommonFn.DataColumnType.STRING,1024),
            new DataColumnInfo(false,true,false,false,"Remark",SqlCommonFn.DataColumnType.STRING,45)
        };

        public static DataColumnInfo getParameterNameColumn()
        {
            return Columns[0];
        }
        public static DataColumnInfo getParameterValueColumn()
        {
            return Columns[1];
        }
        public static DataColumnInfo getRemarkColumn()
        {
            return Columns[2];
        }

        private string _ParameterName = "";
        private string _ParameterValue = "";
        private string _Remark = "";

        public string ParameterName
        {
            get
            {
                return _ParameterName;
            }
            set
            {
                _ParameterName = value;
            }
        }
        public string ParameterValue
        {
            get
            {
                return _ParameterValue;
            }
            set
            {
                _ParameterValue = value;
            }
        }
        public string Remark
        {
            get
            {
                return _Remark;
            }
            set
            {
                _Remark = value;
            }
        }

         public override void SetValue(System.Data.DataRow row)
         {
              _dataRow = row;
             System.Data.DataColumnCollection dataCols = row.Table.Columns;
             if(dataCols.Contains("ParameterName"))
                 SetValue(ref _ParameterName, row["ParameterName"]);
             if(dataCols.Contains("ParameterValue"))
                 SetValue(ref _ParameterValue, row["ParameterValue"]);
             if(dataCols.Contains("Remark"))
                 SetValue(ref _Remark, row["Remark"]);
             if(dataCols.Contains("TEM_COLUMN_COUNT"))
                 SetValue(ref _TEM_COLUMN_COUNT, row["TEM_COLUMN_COUNT"]);
         }


    }
}
