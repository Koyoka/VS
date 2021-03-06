using System;
using System.Collections.Generic;
using System.Text;
using ComLib;
using ComLib.db;

namespace YRKJ.MWR
{
    public class TblMWSynclogCtrl : BaseDataCtrl
    {
        public static bool QueryPage(DataCtrlInfo dcf, SqlWhere sw, int page, int pageSize, ref List<TblMWSynclog> itemList, ref string errMsg)
        {
            SqlQueryMng sqm = new SqlQueryMng();
            sqm.Condition.Where.AddWhere(sw);
            return QueryPage(dcf, sqm, page, pageSize, ref itemList, ref errMsg);
        }
 
        public static bool QueryPage(DataCtrlInfo dcf, SqlQueryMng sqm, int page, int pageSize,ref List<TblMWSynclog> itemList,ref string errMsg)
        {
            try
            {
                sqm.setQueryTableName(TblMWSynclog.getFormatTableName());
                string sql = sqm.getPageSql(page, pageSize);
                SqlCommonFn.DebugLog(sql);
                itemList = SqlDBMng.getInstance().query(sql, new TblMWSynclog(), sqm.getParamsArray());
                if (itemList.Count != 0)
                {
                    dcf.RowCount = itemList[0].TEM_COLUMN_COUNT;
                    dcf.PageCount = ComFn.getPageCount(pageSize, dcf.RowCount);
                }
            }
            catch (Exception e)
            {
                errMsg = e.Message;
                return false;
            }
            return true ;
        }

        public static bool QueryMore(DataCtrlInfo dcf, SqlWhere sw,ref List<TblMWSynclog> itemList,ref string errMsg)
        {
            SqlQueryMng sqm = new SqlQueryMng();
            sqm.Condition.Where.AddWhere(sw);
            return QueryMore(dcf, sqm,ref itemList,ref errMsg);
        }

        public static bool QueryMore(DataCtrlInfo dcf, SqlQueryMng sqm,ref List<TblMWSynclog> itemList,ref string errMsg)
        {
          
            try
            {
                sqm.setQueryTableName(TblMWSynclog.getFormatTableName());
                string sql = sqm.getSql();
                SqlCommonFn.DebugLog(sql);
                itemList = SqlDBMng.getInstance().query(sql, new TblMWSynclog(), sqm.getParamsArray());
            }
            catch (Exception e)
            {
                errMsg = e.Message;
                return false;
            }
            return true;
        }

        public static bool QueryOne(DataCtrlInfo dcf, SqlQueryMng sqm,ref TblMWSynclog item,ref string errMsg)
        {
            List<TblMWSynclog> itemList = null;
            if (!QueryMore(dcf, sqm, ref itemList, ref errMsg))
            {
                return false;
            }

            if (itemList.Count > 0)
            {
                item = itemList[0];
            }
            else
            {
                item = null;
            }

            return true;
        }

        public static bool QueryOne(DataCtrlInfo dcf, SqlWhere sw,ref TblMWSynclog item, ref string errMsg)
        {
            SqlQueryMng sqm = new SqlQueryMng();
            sqm.Condition.Where.AddWhere(sw);
            return QueryOne(dcf, sqm, ref item, ref errMsg);
        }

        public static bool Insert(DataCtrlInfo dcf, TblMWSynclog item, ref int count,ref string errMsg)
        {
            return Insert(dcf,
                item.SyncDateTime,
                item.Status,
                item.Remark,
                item.InCarWeight,
                item.RecoSubWeight,
                item.RecoTxnWeight,
                item.InvWeight,
                item.PostTxnWeight,
                item.DestTxnWeight,
                item.EntryDate,
                    ref count,
                    ref errMsg
                    );
        }

        public static bool Insert(DataCtrlInfo dcf,
            DateTime syncDateTime,
            string status,
            string remark,
            decimal inCarWeight,
            decimal recoSubWeight,
            decimal recoTxnWeight,
            decimal invWeight,
            decimal postTxnWeight,
            decimal destTxnWeight,
            DateTime entryDate,
                ref int _count,
                ref string _errMsg
                )
        {
            SqlUpdateMng sum = new SqlUpdateMng();
            sum.setQueryTableName(TblMWSynclog.getFormatTableName());
            sum.Add(TblMWSynclog.getSyncDateTimeColumn(), syncDateTime);
            sum.Add(TblMWSynclog.getStatusColumn(), status);
            sum.Add(TblMWSynclog.getRemarkColumn(), remark);
            sum.Add(TblMWSynclog.getInCarWeightColumn(), inCarWeight);
            sum.Add(TblMWSynclog.getRecoSubWeightColumn(), recoSubWeight);
            sum.Add(TblMWSynclog.getRecoTxnWeightColumn(), recoTxnWeight);
            sum.Add(TblMWSynclog.getInvWeightColumn(), invWeight);
            sum.Add(TblMWSynclog.getPostTxnWeightColumn(), postTxnWeight);
            sum.Add(TblMWSynclog.getDestTxnWeightColumn(), destTxnWeight);
            sum.Add(TblMWSynclog.getEntryDateColumn(), entryDate);
            string sql = sum.getInsertSql();
            if (sql == null)
            {
                _errMsg = sum.ErrMsg;
                return false;
            }
            return doUpdateCtrl(dcf, sql,ref _count,ref _errMsg);
        }

        public static bool Update(DataCtrlInfo dcf, TblMWSynclog item, SqlWhere sw,ref int count,ref string errMsg)
        {
            SqlUpdateColumn suc = new SqlUpdateColumn();
            suc.Add(TblMWSynclog.getSyncDateTimeColumn(), item.SyncDateTime);
            suc.Add(TblMWSynclog.getStatusColumn(), item.Status);
            suc.Add(TblMWSynclog.getRemarkColumn(), item.Remark);
            suc.Add(TblMWSynclog.getInCarWeightColumn(), item.InCarWeight);
            suc.Add(TblMWSynclog.getRecoSubWeightColumn(), item.RecoSubWeight);
            suc.Add(TblMWSynclog.getRecoTxnWeightColumn(), item.RecoTxnWeight);
            suc.Add(TblMWSynclog.getInvWeightColumn(), item.InvWeight);
            suc.Add(TblMWSynclog.getPostTxnWeightColumn(), item.PostTxnWeight);
            suc.Add(TblMWSynclog.getDestTxnWeightColumn(), item.DestTxnWeight);
            suc.Add(TblMWSynclog.getEntryDateColumn(), item.EntryDate);
            return Update(dcf, suc, sw, ref count, ref errMsg);
        }

        public static bool Update(DataCtrlInfo dcf, TblMWSynclog item, SqlUpdateColumn suc, SqlWhere sw,ref int count,ref string errMsg)
        {
            if (suc.Columns != null)
                 SetUpdateColumnValue(suc, item);
            return Update(dcf, suc, sw, ref count, ref errMsg);
        }

        public static bool Update(DataCtrlInfo dcf, SqlUpdateColumn suc, SqlWhere sw,ref int count,ref string errMsg)
        {
            SqlUpdateMng sum = new SqlUpdateMng();
            sum.setQueryTableName(TblMWSynclog.getFormatTableName());
            string sql = sum.getUpdateSql(suc, sw);
            if (sql == null)
            {
                errMsg = sum.ErrMsg;
                return false;
            }
            return doUpdateCtrl(dcf, sql, ref count,ref errMsg);
        }

        public static bool Delete(DataCtrlInfo dcf, SqlWhere sw, ref int count, ref string errMsg)
        {
            SqlUpdateMng sum = new SqlUpdateMng();
            sum.setQueryTableName(TblMWSynclog.getFormatTableName());
            string sql = sum.getDeleteSql(sw);
            return doUpdateCtrl(dcf, sql, ref count,ref errMsg);
        }




    }
}
