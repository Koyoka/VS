using System;
using System.Collections.Generic;
using System.Text;
using ComLib.db;

namespace MWRDBModule.DBModule
{

    public class TblMWCrate : BaseDataModule
    {

        private static string TableName = "MWCrate";
        public TblMWCrate()
        {
        }
        public static string getFormatTableName()
        {
            return SqlCommonFn.FormatSqlTableNameString(TableName);
        }

        public static DataColumnInfo[] Columns = 
                new DataColumnInfo[]{
            new DataColumnInfo(true,false,false,false,"CrateId",SqlCommonFn.DataColumnType.INT,10),
            new DataColumnInfo(false,true,false,false,"CrateCode",SqlCommonFn.DataColumnType.STRING,20),
            new DataColumnInfo(false,true,false,false,"Desc",SqlCommonFn.DataColumnType.STRING,45),
            new DataColumnInfo(false,true,false,false,"Status",SqlCommonFn.DataColumnType.STRING,2)
        };

        public static DataColumnInfo getCrateIdColumn()
        {
            return Columns[0];
        }
        public static DataColumnInfo getCrateCodeColumn()
        {
            return Columns[1];
        }
        public static DataColumnInfo getDescColumn()
        {
            return Columns[2];
        }
        public static DataColumnInfo getStatusColumn()
        {
            return Columns[3];
        }

        private int _CrateId = 0;
        private string _CrateCode = "";
        private string _Desc = "";
        private string _Status = "";

        public int CrateId
        {
            get
            {
                return _CrateId;
            }
            set
            {
                _CrateId = value;
            }
        }
        public string CrateCode
        {
            get
            {
                return _CrateCode;
            }
            set
            {
                _CrateCode = value;
            }
        }
        public string Desc
        {
            get
            {
                return _Desc;
            }
            set
            {
                _Desc = value;
            }
        }
        public string Status
        {
            get
            {
                return _Status;
            }
            set
            {
                _Status = value;
            }
        }



    }
}