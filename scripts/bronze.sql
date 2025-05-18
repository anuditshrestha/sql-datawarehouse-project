/*
Creating table headings in the bronze table by analyzing the crm csv file.

*/

if object_id ('bronze.crm_cust_info', 'U') is not null
	drop table bronze.crm_cust_info;

create table bronze.crm_cust_info (
cst_id Int,
cst_key Nvarchar(50),
cst_firstname nvarchar(50),
cst_lastname nvarchar(50),
cst_material_status nvarchar(50),
cst_gender nvarchar(50),
cst_create_date Date
);

if object_id ('bronze.crm_prd_info', 'U') is not null
	drop table bronze.crm_prd_info;
create table bronze.crm_prd_info(
prd_id int,
prd_key nvarchar(50),
prd_nm nvarchar(50),
prd_cost int,
prd_line nvarchar(50),
prd_start_dt datetime,
prd_end_dt datetime
);


if object_id ('bronze.crm_sales_details', 'U') is not null
	drop table bronze.crm_sales_details;
create table bronze.crm_sales_details(
sls_ord_num nvarchar(50),
sls_prd_key nvarchar(50),
sls_cust_id int,
sls_order_dt int,
sls_ship_dt int,
sls_due_dt int,
sls_sales int,
sls_quantity int,
sls_price int
);


if object_id ('bronze.erp_lov_a101', 'U') is not null
	drop table bronze.erp_lov_a101;
create table bronze.erp_lov_a101 (
cid nvarchar(50),
cntry nvarchar(50)
);


if object_id ('bronze.erp_cust_az12', 'U') is not null
	drop table bronze.erp_cust_az12;
create table bronze.erp_cust_az12 (
cid nvarchar(50),
bdate date,
gen nvarchar(50)
);


if object_id ('bronze.erp_px_cat_g1v2', 'U') is not null
	drop table bronze.erp_px_cat_g1v2;
create table bronze.erp_px_cat_g1v2 (
id nvarchar(50),
cat nvarchar(50),
subcat nvarchar(50),
maintenance nvarchar(50)
);

/*
Data Extraction: Full Loading by first truncating the table (vacating the table by ensuring there is no content in the table) and loading the contents
Bulk inserting the data from the dataset into the Server 
Also store the procedure by creating the procedure
*/
CREATE or ALTER PROCEDURE bronze.load_bronze as
BEGIN
truncate table bronze.crm_cust_info;
bulk insert bronze.crm_cust_info
from 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with (
	firstrow = 2,
	fieldterminator = ',',
	tablock 
);

truncate table bronze.crm_sales_details;
bulk insert bronze.crm_sales_details
from 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with (
	firstrow = 2,
	fieldterminator = ',',
	tablock 
);


truncate table bronze.crm_prd_info;
bulk insert bronze.crm_prd_info
from 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with (
	firstrow = 2,
	fieldterminator = ',',
	tablock 
);

truncate table bronze.erp_cust_az12;
bulk insert bronze.erp_cust_az12
from 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_AZ12.csv'
with (
	firstrow = 2,
	fieldterminator = ',',
	tablock 
);

truncate table bronze.erp_lov_a101;
bulk insert bronze.erp_lov_a101
from 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
with (
	firstrow = 2,
	fieldterminator = ',',
	tablock 
);

truncate table bronze.erp_px_cat_g1v2;
bulk insert bronze.erp_px_cat_g1v2
from 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.CSV'
with (
	firstrow = 2,
	fieldterminator = ',',
	tablock 
);
END

/*Execute bronze.load_bronze to execute the procedure */
