-- MySQL Script generated by MySQL Workbench
-- 06/04/15 18:03:18
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema MWRData
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema MWRData
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `MWRData` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `MWRData` ;

-- -----------------------------------------------------
-- Table `MWRData`.`MWInventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWInventory` (
  `InvRecordId` INT NOT NULL,
  `CrateCode` VARCHAR(20) NULL COMMENT '货箱编号',
  `DepotCode` VARCHAR(20) NULL COMMENT '仓库编号',
  `Vendor` VARCHAR(45) NULL COMMENT '供货商（医院）',
  `VendorCode` VARCHAR(20) NULL COMMENT '供货商(医院)编号',
  `Waste` VARCHAR(45) NULL COMMENT '废品名称',
  `WasteCode` VARCHAR(20) NULL COMMENT '废品编号',
  `RecoWeight` DECIMAL(10,2) NULL COMMENT '回收重量',
  `InvWeight` DECIMAL(10,2) NULL COMMENT '库存重量',
  `PostWeight` DECIMAL(10,2) NULL COMMENT '出库重量',
  `DestWeight` DECIMAL(10,2) NULL COMMENT '销毁重量',
  `EntryDate` DATETIME NULL COMMENT '数据记录时间',
  `Status` VARCHAR(3) NULL COMMENT '当前库存状态\n1.已入库 RED\n2.已出库PED\n3.已销毁DED\n4.入库中RIN\n5.出库中PIN\n6.销毁中DIN',
  `DailyClose` BIT NULL COMMENT '是否已经日结盘点',
  PRIMARY KEY (`InvRecordId`))
ENGINE = InnoDB
COMMENT = '库存表-记录库存信息，库存来源等';


-- -----------------------------------------------------
-- Table `MWRData`.`MWTxnRecoverHeader`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWTxnRecoverHeader` (
  `RecoHeaderId` INT NOT NULL,
  `TxnNum` VARCHAR(20) NULL COMMENT '交易流水号',
  `CarCode` VARCHAR(20) NULL COMMENT '车辆编号',
  `Driver` VARCHAR(45) NULL COMMENT '司机姓名',
  `DriverCode` VARCHAR(20) NULL COMMENT '司机编号',
  `Inspector` VARCHAR(45) NULL COMMENT '跟车员姓名',
  `InspectorCode` VARCHAR(20) NULL COMMENT '跟车员编号',
  `RecoMWSCode` VARCHAR(20) NULL COMMENT '回收使用的手机终端',
  `RecoWSCode` VARCHAR(20) NULL COMMENT '回收交易处理的回收站',
  `RecoEmpyName` VARCHAR(45) NULL COMMENT '回收交易处理员工姓名',
  `RecoEmpyCode` VARCHAR(20) NULL COMMENT '回收交易处理的员工',
  `StartDate` DATETIME NULL COMMENT '开始时间',
  `EndDate` DATETIME NULL COMMENT '结束时间',
  `EntryDate` DATETIME NULL,
  `OperateType` VARCHAR(2) NULL COMMENT '处理类型-\n1.回收入库  I\n2.直接处置  D',
  `TotalCrateQty` INT NULL COMMENT '交易中箱子的总重量',
  `TotalSubWeight` DECIMAL(10,2) NULL COMMENT '回收提交的总重量',
  `TotalTxnWeight` DECIMAL(10,2) NULL COMMENT '交易完成的实际总重量',
  `CarDisId` INT NULL COMMENT '回收交易的车辆考勤记录',
  `Status` VARCHAR(2) NULL COMMENT '当前交易状态\n1.处理中 P process\n2.完成 C complete\n3.审核中 A authorize',
  PRIMARY KEY (`RecoHeaderId`))
ENGINE = InnoDB
COMMENT = '回收计划信息表-记录提交的回收计划 \n回收入库交易表';


-- -----------------------------------------------------
-- Table `MWRData`.`MWRecoverDetail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWRecoverDetail` (
  `RecoDtlId` INT NOT NULL,
  `RecoHeaderId` INT NULL,
  `CrateCode` VARCHAR(20) NULL,
  `RecoNum` VARCHAR(20) NULL,
  `Vendor` VARCHAR(45) NULL,
  `VendorCode` VARCHAR(20) NULL,
  `Waste` VARCHAR(45) NULL,
  `WasteCode` VARCHAR(20) NULL,
  `RecoWeight` FLOAT NULL,
  `RecoDate` DATETIME NULL,
  `InvAuthId` INT NULL,
  `Status` VARCHAR(2) NULL,
  PRIMARY KEY (`RecoDtlId`))
ENGINE = InnoDB
COMMENT = '回收计划详情表-记录回收计划中包含的废品详情明细';


-- -----------------------------------------------------
-- Table `MWRData`.`MWInventoryTrack`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWInventoryTrack` (
  `InvTrackRecordId` INT NOT NULL,
  `InvRecordId` INT NULL COMMENT '库存变更关联的库存ID',
  `TxnNum` VARCHAR(20) NULL COMMENT '库存变更执行的交易流水号',
  `TxnType` VARCHAR(2) NULL COMMENT '库存变更交易的类型\n1.回收入库 R\n2.出库 P\n3.销毁 D',
  `TxnDetailId` INT NULL COMMENT '库存变更关联的交易明细',
  `CrateCode` VARCHAR(20) NULL COMMENT '变更的货箱编号',
  `DepotCode` VARCHAR(20) NULL COMMENT '变更货箱的仓库编号',
  `Vendor` VARCHAR(45) NULL COMMENT '供货商（医院）编号',
  `VendorCode` VARCHAR(20) NULL COMMENT '供货商（医院）',
  `Waste` VARCHAR(45) NULL COMMENT '废品名称',
  `WasteCode` VARCHAR(20) NULL COMMENT '废品编号',
  `SubWeight` DECIMAL(10,2) NULL COMMENT '库存变更的提交重量',
  `TxnWeight` DECIMAL(10,2) NULL COMMENT '库存变更的成交重量',
  `WSCode` VARCHAR(20) NULL COMMENT '库存操作工作站编号',
  `EmpyName` VARCHAR(45) NULL COMMENT '库存操作员姓名',
  `EmpyCode` VARCHAR(20) NULL COMMENT '库存操作员工编号',
  `EntryDate` DATETIME NULL COMMENT '库存变更的提交时间',
  `Status` VARCHAR(2) NULL COMMENT '库存变更的操作状态\n1.Normal 该跟踪数据正常\n2.Void 该跟踪数据无效',
  `InvAuthId` INT NULL COMMENT '变更完成包含的审核信息ID',
  PRIMARY KEY (`InvTrackRecordId`))
ENGINE = InnoDB
COMMENT = '库存跟踪表-记录每次库存交易操作信息，（现在是两个工作站）\n库存变化的记录';


-- -----------------------------------------------------
-- Table `MWRData`.`MWInventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWInventory` (
  `InvRecordId` INT NOT NULL,
  `CrateCode` VARCHAR(20) NULL COMMENT '货箱编号',
  `DepotCode` VARCHAR(20) NULL COMMENT '仓库编号',
  `Vendor` VARCHAR(45) NULL COMMENT '供货商（医院）',
  `VendorCode` VARCHAR(20) NULL COMMENT '供货商(医院)编号',
  `Waste` VARCHAR(45) NULL COMMENT '废品名称',
  `WasteCode` VARCHAR(20) NULL COMMENT '废品编号',
  `RecoWeight` DECIMAL(10,2) NULL COMMENT '回收重量',
  `InvWeight` DECIMAL(10,2) NULL COMMENT '库存重量',
  `PostWeight` DECIMAL(10,2) NULL COMMENT '出库重量',
  `DestWeight` DECIMAL(10,2) NULL COMMENT '销毁重量',
  `EntryDate` DATETIME NULL COMMENT '数据记录时间',
  `Status` VARCHAR(3) NULL COMMENT '当前库存状态\n1.已入库 RED\n2.已出库PED\n3.已销毁DED\n4.入库中RIN\n5.出库中PIN\n6.销毁中DIN',
  `DailyClose` BIT NULL COMMENT '是否已经日结盘点',
  PRIMARY KEY (`InvRecordId`))
ENGINE = InnoDB
COMMENT = '库存表-记录库存信息，库存来源等';


-- -----------------------------------------------------
-- Table `MWRData`.`MWTxnPostHeader`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWTxnPostHeader` (
  `PostHeaderId` INT NOT NULL,
  `TxnNum` VARCHAR(20) NULL,
  `PostWSCode` VARCHAR(20) NULL COMMENT '库存操作工作站编号',
  `PostEmpyName` VARCHAR(45) NULL,
  `PostEmpyCode` VARCHAR(20) NULL COMMENT '库存操作员工编号',
  `StartDate` DATETIME NULL,
  `EndDate` DATETIME NULL,
  `PostType` VARCHAR(2) NULL COMMENT '出库类型\nNomarl = \"N\";//1.正常-称重出库\nSpecial = \"S\";//2.特殊-直接出库\nAuto = \"A\";//3.自动-由处理工作站发起自动生成出库交易信息',
  `TotalCrateQty` INT NULL COMMENT '交易中箱子的总重量',
  `TotalSubWeight` DECIMAL(10,2) NULL COMMENT '出库提交的总重量',
  `TotalTxnWeight` DECIMAL(10,2) NULL COMMENT '交易完成的实际总重量',
  `Status` VARCHAR(2) NULL COMMENT '当前交易状态\n1.处理中 P process\n2.完成 C complete\n3.审核中 A authorize',
  PRIMARY KEY (`PostHeaderId`))
ENGINE = InnoDB
COMMENT = '出库交易信息表';


-- -----------------------------------------------------
-- Table `MWRData`.`MWPostDetail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWPostDetail` (
  `PostDtlId` INT NOT NULL,
  `PostHeaderId` INT NULL,
  `CrateCode` VARCHAR(20) NULL,
  `PostNum` VARCHAR(20) NULL,
  `DepotCode` VARCHAR(20) NULL COMMENT '仓库编号',
  `Vendor` VARCHAR(45) NULL,
  `VendorCode` VARCHAR(20) NULL,
  `Waste` VARCHAR(45) NULL,
  `WasteCode` VARCHAR(20) NULL,
  `InvWeight` FLOAT NULL,
  `PostWeight` FLOAT NULL,
  `Status` VARCHAR(2) NULL,
  `InvRecordId` INT NULL COMMENT '关联库存ID',
  `InvAuthId` INT NULL,
  PRIMARY KEY (`PostDtlId`))
ENGINE = InnoDB
COMMENT = '出库交易详情表';


-- -----------------------------------------------------
-- Table `MWRData`.`MWTxnDestroyHeader`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWTxnDestroyHeader` (
  `DestHeaderId` INT NOT NULL,
  `TxnNum` VARCHAR(20) NULL COMMENT '销毁交易的流水号',
  `DestType` VARCHAR(2) NULL COMMENT '处置类型\n1.回收处置 RD\n2.出库处置 PD',
  `StartDate` DATETIME NULL COMMENT '交易开始的时间',
  `EndDate` DATETIME NULL COMMENT '交易结束的时间',
  `DestWSCode` VARCHAR(20) NULL,
  `DestEmpyName` VARCHAR(45) NULL,
  `DestEmpyCode` VARCHAR(20) NULL,
  `TotalCrateQty` INT NULL COMMENT '销毁的箱子总数量',
  `TotalSubWeight` DECIMAL(10,2) NULL COMMENT '销毁提交的总重量',
  `TotalTxnWeight` DECIMAL(10,2) NULL COMMENT '交易完成的实际总重量',
  `Status` VARCHAR(2) NULL COMMENT '销毁交易的状态\n1.处理中\n2.完成\n3.审核中',
  PRIMARY KEY (`DestHeaderId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MWRData`.`MWDestroyDetail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWDestroyDetail` (
  `DestroyDtlId` INT NOT NULL,
  `CrateCode` VARCHAR(20) NULL,
  `DestHeaderId` INT NULL,
  `DestNum` VARCHAR(20) NULL,
  `DepotCode` VARCHAR(20) NULL COMMENT '仓库编号',
  `Vendor` VARCHAR(45) NULL,
  `VendorCode` VARCHAR(20) NULL,
  `Waste` VARCHAR(45) NULL,
  `WasteCode` VARCHAR(20) NULL,
  `PostWeight` FLOAT NULL,
  `DestWeight` FLOAT NULL,
  `Status` VARCHAR(2) NULL,
  `PostHeaderId` INT NULL,
  `InvRecordId` INT NULL COMMENT '关联库存ID',
  `InvAuthId` INT NULL,
  PRIMARY KEY (`DestroyDtlId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MWRData`.`SysNextId`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`SysNextId` (
  `IdName` VARCHAR(128) NOT NULL,
  `MinValue` INT NULL,
  `Increment` INT NULL,
  `MaxValue` INT NULL,
  `IdValue` INT NULL,
  PRIMARY KEY (`IdName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MWRData`.`SysParameter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`SysParameter` (
  `ParameterName` VARCHAR(128) NOT NULL,
  `ParameterValue` VARCHAR(1024) NULL,
  `Remark` VARCHAR(45) NULL,
  PRIMARY KEY (`ParameterName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MWRData`.`MWInvAuthorizeAttach`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWInvAuthorizeAttach` (
  `InvAttachId` INT NOT NULL,
  `InvAuthId` INT NULL,
  `Path` VARCHAR(128) NULL,
  PRIMARY KEY (`InvAttachId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MWRData`.`MWInvAuthorize`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWInvAuthorize` (
  `InvAuthId` INT NOT NULL,
  `TxnNum` VARCHAR(20) NULL COMMENT '交易编号',
  `TxnDetailId` INT NULL COMMENT '当前审核交易货箱的ID',
  `EmpyCode` VARCHAR(20) NULL COMMENT '提交的工作人员编号',
  `EmpyName` VARCHAR(45) NULL COMMENT '提交审核工作员姓名',
  `WSCode` VARCHAR(20) NULL COMMENT '提交的工作站编号',
  `AuthEmpyCode` VARCHAR(20) NULL COMMENT '审核员编号',
  `AuthEmpyName` VARCHAR(45) NULL COMMENT '审核员姓名',
  `Remark` VARCHAR(45) NULL COMMENT '审核备注',
  `SubWeight` DECIMAL(10,2) NULL COMMENT '提交的重量',
  `TxnWeight` DECIMAL(10,2) NULL COMMENT '交易中实际的重量',
  `DiffWeight` DECIMAL(10,2) NULL COMMENT '重量差值',
  `EntryDate` DATETIME NULL COMMENT '审核提交的时间',
  `CompDate` DATETIME NULL COMMENT '审核完成的时间',
  `Status` VARCHAR(2) NULL COMMENT '审核的状态\n1.提交等待审核中\n2.审核完成',
  PRIMARY KEY (`InvAuthId`))
ENGINE = InnoDB
COMMENT = '废品审核授权表-对有缺陷的废品进行人工审核授权记录，并记录附件\n审核时针对交易的审核';


-- -----------------------------------------------------
-- Table `MWRData`.`MWCarDispatch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWCarDispatch` (
  `CarDisId` INT NOT NULL,
  `CarCode` VARCHAR(20) NULL,
  `Driver` VARCHAR(45) NULL COMMENT '司机姓名',
  `DriverCode` VARCHAR(20) NULL COMMENT '司机编号',
  `Inspector` VARCHAR(45) NULL COMMENT '跟车员姓名',
  `InspectorCode` VARCHAR(20) NULL COMMENT '跟车员编号',
  `RecoMWSCode` VARCHAR(20) NULL COMMENT '回收使用的手机终端',
  `OutDate` DATETIME NULL,
  `InDate` DATETIME NULL,
  `Status` VARCHAR(2) NULL COMMENT '车辆派遣状态\n1.班次开始 S strat\n2.班次完成 E end',
  PRIMARY KEY (`CarDisId`))
ENGINE = InnoDB
COMMENT = '车辆班次信息记录';


-- -----------------------------------------------------
-- Table `MWRData`.`SysLog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`SysLog` (
  `LogId` INT NOT NULL,
  `Desc` VARCHAR(45) NULL,
  `Remark` TEXT NULL,
  `LogDate` DATETIME NULL,
  PRIMARY KEY (`LogId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MWRData`.`MWEmploy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWEmploy` (
  `EmpyCode` VARCHAR(20) NOT NULL,
  `EmpyName` VARCHAR(45) NULL,
  `FuncGroupId` INT NULL,
  `EmpyType` VARCHAR(2) NULL COMMENT '员工类型\n1.司机 D\n2.跟车员 I\n3.工作站操作员 W',
  `UserName` VARCHAR(45) NULL,
  `Password` VARCHAR(45) NULL,
  `Status` VARCHAR(2) NULL,
  PRIMARY KEY (`EmpyCode`))
ENGINE = InnoDB
COMMENT = '员工表-记录员工信息，以及员工用户组';


-- -----------------------------------------------------
-- Table `MWRData`.`MWUserGroup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWUserGroup` (
  `UserGroupId` INT NOT NULL,
  `GroupName` VARCHAR(45) NULL,
  PRIMARY KEY (`UserGroupId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MWRData`.`MWVendor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWVendor` (
  `VendorCode` VARCHAR(20) NOT NULL,
  `Vendor` VARCHAR(45) NULL,
  `Address` VARCHAR(128) NULL,
  PRIMARY KEY (`VendorCode`))
ENGINE = InnoDB
COMMENT = '供货商（医院）基础数据';


-- -----------------------------------------------------
-- Table `MWRData`.`MWFunction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWFunction` (
  `FuncTag` VARCHAR(45) NOT NULL,
  `FuncName` VARCHAR(45) NULL,
  PRIMARY KEY (`FuncTag`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MWRData`.`MWUserPermission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWUserPermission` (
  `id` INT NOT NULL,
  `UserGroupId` INT NULL,
  `FuncGroupId` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '用户权限表-记录用户组使用的功能';


-- -----------------------------------------------------
-- Table `MWRData`.`MWFunctionGroup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWFunctionGroup` (
  `FuncGroupId` INT NOT NULL,
  `FuncGroupName` VARCHAR(45) NULL,
  PRIMARY KEY (`FuncGroupId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MWRData`.`MWFunctionGroupDetail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWFunctionGroupDetail` (
  `FuncGroupDtlId` INT NOT NULL,
  `FuncGroupId` INT NULL,
  `FuncTag` VARCHAR(45) NULL,
  PRIMARY KEY (`FuncGroupDtlId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MWRData`.`MWCar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWCar` (
  `CarCode` VARCHAR(20) NOT NULL,
  `Desc` VARCHAR(45) NULL,
  `Status` VARCHAR(2) NULL,
  PRIMARY KEY (`CarCode`))
ENGINE = InnoDB
COMMENT = '车辆基础数据';


-- -----------------------------------------------------
-- Table `MWRData`.`MWCrate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWCrate` (
  `CrateCode` VARCHAR(20) NOT NULL,
  `Desc` VARCHAR(45) NULL,
  `Status` VARCHAR(2) NULL COMMENT '货箱状态\n1.使用中 A active\n2.作废 V void',
  PRIMARY KEY (`CrateCode`))
ENGINE = InnoDB
COMMENT = '货箱基础数据';


-- -----------------------------------------------------
-- Table `MWRData`.`MWDepot`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWDepot` (
  `DeptCode` VARCHAR(20) NOT NULL,
  `Total` INT NULL,
  `Desc` VARCHAR(45) NULL,
  PRIMARY KEY (`DeptCode`))
ENGINE = InnoDB
COMMENT = '库房基础数据';


-- -----------------------------------------------------
-- Table `MWRData`.`MWWasteCategory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWWasteCategory` (
  `WasteCode` VARCHAR(20) NOT NULL,
  `Waste` VARCHAR(45) NULL,
  PRIMARY KEY (`WasteCode`))
ENGINE = InnoDB
COMMENT = '危险品种类数据';


-- -----------------------------------------------------
-- Table `MWRData`.`MWResidueInventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWResidueInventory` (
  `ResdInvId` INT NOT NULL,
  `InvWeight` DECIMAL(10,2) NULL,
  `EntryDate` DATETIME NULL,
  `HandlingDate` DATETIME NULL COMMENT '处理时间',
  `RecoWSCode` VARCHAR(20) NULL,
  `RecoEmpyCode` VARCHAR(20) NULL,
  `HandlingType` VARCHAR(2) NULL COMMENT '处理方式\n1.埋\n2.烧',
  PRIMARY KEY (`ResdInvId`))
ENGINE = InnoDB
COMMENT = '残渣库存记录-记录残渣库存信息';


-- -----------------------------------------------------
-- Table `MWRData`.`MWTxnLog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWTxnLog` (
  `TxnLogId` INT NOT NULL,
  `TxnNum` VARCHAR(20) NULL,
  `TxnDetailId` INT NULL COMMENT '交易明细ID',
  `WSCode` VARCHAR(20) NULL,
  `EmpyName` VARCHAR(45) NULL,
  `EmpyCode` VARCHAR(20) NULL,
  `OptType` VARCHAR(2) NULL COMMENT '操作类型\n1.提交入库 SI  submit inventory\n2.提交审核 SA submit authorize\n3.确认审核并入库 AI authorize inventory',
  `OptDate` DATETIME NULL COMMENT '执行操作的时间',
  `TxnLogType` VARCHAR(2) NULL COMMENT '库存日志的类型 -废品出库，废品入库，残渣出库，残渣入库\n1.回收入库 R\n2.出库 P\n3.销毁 D',
  `InvRecordId` INT NULL COMMENT '如果有库存 交易日志关联的库存\n',
  PRIMARY KEY (`TxnLogId`))
ENGINE = InnoDB
COMMENT = '库存处理交易日志-出入库存中操作的wscode empycode为最终库存操作者，本表中记录某个库存操作的变化的日志\n包括废品出库，废品入库，残渣出库，残渣入库';


-- -----------------------------------------------------
-- Table `MWRData`.`MWTxnDetail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWTxnDetail` (
  `TxnDetailId` INT NOT NULL,
  `TxnType` VARCHAR(2) NULL COMMENT '当前交易明细产生的交易类型\n1.回收入库 R\n2.出库 P\n3.销毁 D\n//4.终端提交 S',
  `TxnNum` VARCHAR(20) NULL COMMENT '库存交易流水号',
  `WSCode` VARCHAR(20) NULL COMMENT '操作工作站',
  `EmpyName` VARCHAR(45) NULL,
  `EmpyCode` VARCHAR(20) NULL COMMENT '操作员',
  `CrateCode` VARCHAR(20) NULL,
  `Vendor` VARCHAR(45) NULL COMMENT '供货商（医院）',
  `VendorCode` VARCHAR(20) NULL,
  `Waste` VARCHAR(45) NULL COMMENT '医疗废品名称',
  `WasteCode` VARCHAR(20) NULL,
  `SubWeight` DECIMAL(10,2) NULL COMMENT '当前交易提交重量',
  `TxnWeight` DECIMAL(10,2) NULL COMMENT '交易成交重量（实际重量）',
  `EntryDate` DATETIME NULL COMMENT '当前货箱交易添加时间',
  `InvRecordId` INT NULL COMMENT '交易关联的库存ID',
  `InvAuthId` INT NULL COMMENT '审核交易的ID',
  `Status` VARCHAR(2) NULL COMMENT '当前交易的货箱状态\n1.交易完成 C complete\n2.交易货箱审核中 A authorize\n3.交易货箱审核完成，等待确认 W wait',
  PRIMARY KEY (`TxnDetailId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MWRData`.`MWWorkStation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWWorkStation` (
  `WSCode` VARCHAR(20) NOT NULL COMMENT '处置工作站，出入库工作站 WS00#\n手机终端 MWS00#',
  `Desc` VARCHAR(45) NULL,
  `WSType` VARCHAR(2) NULL COMMENT '工作终端类型\n1.出入库 I\n2.处置 D\n3手机 M',
  `AccessKey` VARCHAR(40) NULL COMMENT '终端访问KEY',
  `SecretKey` VARCHAR(40) NULL COMMENT '加密key',
  PRIMARY KEY (`WSCode`))
ENGINE = InnoDB
COMMENT = '工作站基础数据表\n包含 处置工作站 出入库工作站 手机终端';


-- -----------------------------------------------------
-- Table `MWRData`.`MWSyncLog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MWRData`.`MWSyncLog` (
  `SyncDateTime` DATETIME NOT NULL,
  `Status` VARCHAR(2) NULL,
  `Remark` VARCHAR(128) NULL,
  `InCarWeight` DECIMAL(10,2) NULL,
  `RecoSubWeight` DECIMAL(10,2) NULL,
  `RecoTxnWeight` DECIMAL(10,2) NULL,
  `InvWeight` DECIMAL(10,2) NULL,
  `PostTxnWeight` DECIMAL(10,2) NULL,
  `DestTxnWeight` DECIMAL(10,2) NULL,
  `EntryDate` DATETIME NULL,
  PRIMARY KEY (`SyncDateTime`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
