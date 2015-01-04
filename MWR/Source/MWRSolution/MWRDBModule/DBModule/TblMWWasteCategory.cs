using System;
using System.Collections.Generic;
using System.Text;
using ComLib.db;

namespace MWRDBModule.DBModule
{

    public class TblMWWasteCategory : BaseDataModule
    {

        private static string TableName = "MWWasteCategory";
        public TblMWWasteCategory()
        {
        }
        public static string getFormatTableName()
        {
            return SqlCommonFn.FormatSqlTableNameString(TableName);
        }

        public static DataColumnInfo[] Columns = 
                new DataColumnInfo[]{
            new DataColumnInfo(true,false,false,false,"CateId",SqlCommonFn.DataColumnType.INT,10),
            new DataColumnInfo(false,true,false,false,"WasteCode",SqlCommonFn.DataColumnType.STRING,20),
            new DataColumnInfo(false,true,false,false,"Waste",SqlCommonFn.DataColumnType.STRING,45)
        };

        public static DataColumnInfo getCateIdColumn()
        {
            return Columns[0];
        }
        public static DataColumnInfo getWasteCodeColumn()
        {
            return Columns[1];
        }
        public static DataColumnInfo getWasteColumn()
        {
            return Columns[2];
        }

        private int _CateId = 0;
        private string _WasteCode = "";
        private string _Waste = "";

        public int CateId
        {
            get
            {
                return _CateId;
            }
            set
            {
                _CateId = value;
            }
        }
        public string WasteCode
        {
            get
            {
                return _WasteCode;
            }
            set
            {
                _WasteCode = value;
            }
        }
        public string Waste
        {
            get
            {
                return _Waste;
            }
            set
            {
                _Waste = value;
            }
        }



    }
}