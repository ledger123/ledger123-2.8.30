-- Japanese COA General Purpose - Corrections
-- First Choice Internet Ltd., B.Plagge, 23 Mar. 2010
-- account deletion, account corrections and number change
--
-- deletions
DELETE FROM chart WHERE accno='1310';
DELETE FROM chart WHERE accno='3030';
DELETE FROM chart WHERE accno='3100';
DELETE FROM chart WHERE accno='4200';
DELETE FROM chart WHERE accno='4210';
DELETE FROM chart WHERE accno='4220';
DELETE FROM chart WHERE accno='4230';
DELETE FROM chart WHERE accno='4240';
DELETE FROM chart WHERE accno='5200';
DELETE FROM chart WHERE accno='5300';
DELETE FROM chart WHERE accno='5350';
DELETE FROM chart WHERE accno='5400';
DELETE FROM chart WHERE accno='5450';
DELETE FROM chart WHERE accno='5500';
DELETE FROM chart WHERE accno='7130';
DELETE FROM chart WHERE accno='7999';
--
--
-- account definition changes

UPDATE chart SET description='Note Payments', charttype='A', category='L', link='AP' WHERE accno='3020';
UPDATE chart SET description='Dishonored Notes', charttype='A', category='L', link='' WHERE accno='3040';
UPDATE chart SET description='Expenses Payabe', charttype='A', category='L', link=''	WHERE accno='3060';
UPDATE chart SET description='Company Tax Payable', charttype='A', category='L', link=''	WHERE accno='3070';
UPDATE chart SET description='Enterprise Tax Payable', charttype='A', category='L', link='' WHERE accno='3080';
UPDATE chart SET description='Software', charttype='A', category='A', link=''	WHERE accno='1180';
UPDATE chart SET description='Dividends Payable', charttype='A', category='L', link='' WHERE accno='3110';
UPDATE chart SET description='Executive Bonus Payable', charttype='A', category='L', link=''	WHERE accno='3120';
UPDATE chart SET description='Emoluments Payable', charttype='A', category='L', link=''	WHERE accno='3130';
UPDATE chart SET description='Outstanding Shareholders Payment', charttype='A', category='L', link=''	WHERE accno='3140';
UPDATE chart SET description='Employee Taxes Retained', charttype='A', category='L', link='	IC_expense' WHERE accno='3150';
UPDATE chart SET description='Deferred Tax Liability', charttype='A', category='L', link='' WHERE accno='3160';
UPDATE chart SET description='Consumption Tax (PO) 5%)', charttype='A', category='L', link='P_tax:IC_taxpart:IC_taxservice' 	WHERE accno='3240';
UPDATE chart SET description='Long Term Liabilities', charttype='H', category='L', link='' 	WHERE accno='3500';
UPDATE chart SET description='Payroll Expenses', charttype='H', category='E', link='' 	WHERE accno='4500';
UPDATE chart SET description='Sales Revenue', charttype='H', category='I', link='' WHERE accno='4700';
UPDATE chart SET description='Regular Sales', charttype='A', category='I', link='AR_amount:IC_sale' WHERE accno='4710';
UPDATE chart SET description='Sales of Services', charttype='A', category='I', link='AR_amount:IC_income' WHERE accno='4720';
UPDATE chart SET description='Sales Reductions', charttype='A', category='I', link='' 	WHERE accno='4730';
UPDATE chart SET description='PO Discounts Received', charttype='A', category='I', link='' 	WHERE accno='4740';
UPDATE chart SET description='Cost of Goods Sold', charttype='H', category='E', link=''	WHERE accno='4800';
UPDATE chart SET description='Surcharge Indirect Sales Costs', charttype='A', category='E', link='' WHERE accno='4810';
--
-- accno and description change
UPDATE chart SET description='Guarantee Money Paid', accno='91310', charttype='A', category='A', gifi_accno='1310' WHERE accno='3510';
--
-- accno change -> set temporary number to avoid number clashes	
--
UPDATE chart SET accno='95440', charttype='A', category='E', gifi_accno='5440' WHERE accno='5210';
UPDATE chart SET accno='95470', charttype='A', category='E', link='IC_expense', gifi_accno='5470' WHERE accno='5220';
UPDATE chart SET accno='95450', charttype='A', category='E', gifi_accno='5450' WHERE accno='5230';
UPDATE chart SET accno='95420', charttype='A', category='E', gifi_accno='5420' WHERE accno='5310';
UPDATE chart SET accno='95430', charttype='A', category='E', gifi_accno='5430' WHERE accno='5360';
UPDATE chart SET accno='95410', charttype='A', category='E', gifi_accno='5410' WHERE accno='5410';
UPDATE chart SET accno='95460', charttype='A', category='E', gifi_accno='5460' WHERE accno='5460';
UPDATE chart SET accno='95310', charttype='A', category='E', gifi_accno='5310' WHERE accno='5510';
UPDATE chart SET accno='95320', charttype='A', category='E', gifi_accno='5320' WHERE accno='5520';
UPDATE chart SET accno='95330', charttype='A', category='E', gifi_accno='5330' WHERE accno='5530';
UPDATE chart SET accno='95200', charttype='H', category='E', gifi_accno='5200' WHERE accno='5550';
UPDATE chart SET accno='95210', charttype='A', category='E', gifi_accno='5210' WHERE accno='5560';
UPDATE chart SET accno='95220', charttype='A', category='E', gifi_accno='5220' WHERE accno='5570';
UPDATE chart SET accno='94960', charttype='A', category='E', gifi_accno='4960' WHERE accno='5090';
UPDATE chart SET accno='94970', charttype='A', category='E', gifi_accno='4970' WHERE accno='5100';
UPDATE chart SET accno='94750', charttype='H', category='I', gifi_accno='4750' WHERE accno='7000';
UPDATE chart SET accno='94755', charttype='A', category='I', gifi_accno='4755' WHERE accno='7010';
UPDATE chart SET accno='94760', charttype='A', category='I', gifi_accno='4760' WHERE accno='7030';
UPDATE chart SET accno='94765', charttype='A', category='I', gifi_accno='4765' WHERE accno='7050';
UPDATE chart SET accno='94770', charttype='A', category='I', gifi_accno='4770' WHERE accno='7070';
UPDATE chart SET accno='94775', charttype='A', category='I', gifi_accno='4775' WHERE accno='7120';
UPDATE chart SET accno='94780', charttype='A', category='I', gifi_accno='4780' WHERE accno='7100';
UPDATE chart SET accno='94900', charttype='H', category='E', gifi_accno='4900' WHERE accno='7000';
UPDATE chart SET accno='94910', charttype='A', category='E', gifi_accno='4910' WHERE accno='7040';
UPDATE chart SET accno='94920', charttype='A', category='E', gifi_accno='4920' WHERE accno='7060';
UPDATE chart SET accno='94930', charttype='A', category='E', gifi_accno='4930' WHERE accno='7080';
UPDATE chart SET accno='94940', charttype='A', category='E', gifi_accno='4940' WHERE accno='7110';
UPDATE chart SET accno='94800', charttype='A', category='E', gifi_accno='4800' WHERE accno='7020';
UPDATE chart SET accno='94950', charttype='A', category='E', gifi_accno='4950' WHERE accno='7090';
UPDATE chart SET description='Other Revenue', charttype='H', category='I' WHERE accno='94750';
UPDATE chart SET description='Foreign Currency Gains' WHERE accno='94760';
--
-- now final number change
-- 5000 Profits
-- 5800 Intermediate Account
-- 6000 Sales Revenue
-- 6500 Other Revenue
-- 7000 COGS
-- 7100 Extra Costs
-- 7200 Legal Setup
-- 7300 Depreciation
-- 7500 Payroll
-- 7800 Taxes & Duties
-- 8000 Non Admin Costs
-- 8200 Admin Costs
-- 8900 Adjustments
-- 
-- account 1310
UPDATE chart SET accno='1310', gifi_accno='1310' WHERE accno='91310';
-- 4700 -> 6000
UPDATE chart SET accno='6000', gifi_accno='6000' WHERE accno='4700';
UPDATE chart SET accno='6010', gifi_accno='6010' WHERE accno='4710';
UPDATE chart SET accno='6020', gifi_accno='6020' WHERE accno='4720';
UPDATE chart SET accno='6030', gifi_accno='6030' WHERE accno='4730';
UPDATE chart SET accno='6040', gifi_accno='6040' WHERE accno='4740';
-- 4750 -> 6500, 9475* -> 65*
UPDATE chart SET accno='6500', gifi_accno='6500' WHERE accno='94750';
UPDATE chart SET accno='6510', gifi_accno='6510' WHERE accno='94755';
UPDATE chart SET accno='6520', gifi_accno='6520' WHERE accno='94760';
UPDATE chart SET accno='6530', gifi_accno='6530' WHERE accno='94765';
UPDATE chart SET accno='6540', gifi_accno='6540' WHERE accno='94770';
UPDATE chart SET accno='6550', gifi_accno='6550' WHERE accno='94775';
UPDATE chart SET accno='6560', gifi_accno='6560' WHERE accno='94780';
-- 4800 -> 7000
UPDATE chart SET accno='7000', gifi_accno='7000' WHERE accno='4800';
UPDATE chart SET accno='7010', gifi_accno='7010' WHERE accno='4810';
UPDATE chart SET accno='7020', gifi_accno='7020' WHERE accno='4820';
UPDATE chart SET accno='7030', gifi_accno='7030' WHERE accno='4830';
UPDATE chart SET accno='7040', gifi_accno='7040' WHERE accno='4840';
-- 4900 -> 7100, 949* -> 71*
INSERT INTO chart (accno,description,charttype,category,link,gifi_accno,contra) VALUES ('7100','Extraordinary Costs','H','E','','7100','0');
-- UPDATE chart SET accno='7100', gifi_accno='7100' WHERE accno='94900';
UPDATE chart SET accno='7110', gifi_accno='7110' WHERE accno='94910';
UPDATE chart SET accno='7120', gifi_accno='7120' WHERE accno='94920';
UPDATE chart SET accno='7130', gifi_accno='7130' WHERE accno='94930';
UPDATE chart SET accno='7140', gifi_accno='7140' WHERE accno='94940';
UPDATE chart SET accno='7150', gifi_accno='7150' WHERE accno='94950';
UPDATE chart SET accno='7160', gifi_accno='7160' WHERE accno='94960';
UPDATE chart SET accno='7170', gifi_accno='7170' WHERE accno='94970';
-- 5200 -> 7200
UPDATE chart SET accno='7200', gifi_accno='7200' WHERE accno='95200';
UPDATE chart SET accno='7210', gifi_accno='7210' WHERE accno='95210';
UPDATE chart SET accno='7220', gifi_accno='7220' WHERE accno='95220';
-- 5000 -> 7300
UPDATE chart SET accno='7300', gifi_accno='7300' WHERE accno='5000';
UPDATE chart SET accno='7310', gifi_accno='7310' WHERE accno='5010';
UPDATE chart SET accno='7320', gifi_accno='7320' WHERE accno='5020';
UPDATE chart SET accno='7350', gifi_accno='7350' WHERE accno='5050';
UPDATE chart SET accno='7360', gifi_accno='7360' WHERE accno='5060';
UPDATE chart SET accno='7370', gifi_accno='7370' WHERE accno='5070';
UPDATE chart SET accno='7380', gifi_accno='7280' WHERE accno='5080';
-- 4300 -> 5000
UPDATE chart SET accno='5000', gifi_accno='5000' WHERE accno='4300';
UPDATE chart SET accno='5010', gifi_accno='5010' WHERE accno='4310';
UPDATE chart SET accno='5020', gifi_accno='5020' WHERE accno='4320';
-- 4500 -> 7500
UPDATE chart SET accno='7500', gifi_accno='7500' WHERE accno='4500';
UPDATE chart SET accno='7510', gifi_accno='7510' WHERE accno='4510';
UPDATE chart SET accno='7520', gifi_accno='7510' WHERE accno='4520';
UPDATE chart SET accno='7530', gifi_accno='7530' WHERE accno='4530';
UPDATE chart SET accno='7540', gifi_accno='7540' WHERE accno='4540';
UPDATE chart SET accno='7550', gifi_accno='7550' WHERE accno='4550';
UPDATE chart SET accno='7560', gifi_accno='7560' WHERE accno='4560';
UPDATE chart SET accno='7570', gifi_accno='7570' WHERE accno='4570';
UPDATE chart SET accno='7580', gifi_accno='7580' WHERE accno='4580';
UPDATE chart SET accno='7590', gifi_accno='7590' WHERE accno='4590';
UPDATE chart SET accno='7600', gifi_accno='7600' WHERE accno='4600';
-- 5300 -> 7800, 953* -> 78*
INSERT INTO chart (accno,description,charttype,category,link,gifi_accno,contra) VALUES ('7800','Taxes & Duties','H','E','','7800','0');
-- UPDATE chart SET accno='7800', gifi_accno='7800' WHERE accno='5300';
UPDATE chart SET accno='7810', gifi_accno='7810' WHERE accno='95310';
UPDATE chart SET accno='7820', gifi_accno='7820' WHERE accno='95320';
UPDATE chart SET accno='7830', gifi_accno='7830' WHERE accno='95330';
-- 5400 -> 8000, 954* -> 80*
INSERT INTO chart (accno,description,charttype,category,link,gifi_accno,contra) VALUES ('8000','Non Admin Costs','H','E','','8000','0');
--UPDATE chart SET accno='8000', gifi_accno='8000' WHERE accno='5400';
UPDATE chart SET accno='8010', gifi_accno='8010' WHERE accno='95410';
UPDATE chart SET accno='8020', gifi_accno='8020' WHERE accno='95420';
UPDATE chart SET accno='8030', gifi_accno='8030' WHERE accno='95430';
UPDATE chart SET accno='8040', gifi_accno='8040' WHERE accno='95440';
UPDATE chart SET accno='8050', gifi_accno='8050' WHERE accno='95450';
UPDATE chart SET accno='8060', gifi_accno='8060' WHERE accno='95460';
UPDATE chart SET accno='8080', gifi_accno='8080' WHERE accno='95480';
-- 5600 -> 8200
UPDATE chart SET accno='8200', gifi_accno='8200' WHERE accno='5600';
UPDATE chart SET accno='8210', gifi_accno='8210' WHERE accno='95470';
UPDATE chart SET accno='8220', gifi_accno='8220' WHERE accno='5610';
UPDATE chart SET accno='8230', gifi_accno='8230' WHERE accno='5620';
UPDATE chart SET accno='8240', gifi_accno='8240' WHERE accno='5630';
UPDATE chart SET accno='8250', gifi_accno='8250' WHERE accno='5640';
UPDATE chart SET accno='8260', gifi_accno='8260' WHERE accno='5650';
UPDATE chart SET accno='8270', gifi_accno='8270' WHERE accno='5660';
UPDATE chart SET accno='8280', gifi_accno='8280' WHERE accno='5670';
UPDATE chart SET accno='8290', gifi_accno='8290' WHERE accno='5680';
UPDATE chart SET accno='8300', gifi_accno='8300' WHERE accno='5690';
UPDATE chart SET accno='8310', gifi_accno='8310' WHERE accno='5700';
UPDATE chart SET accno='8320', gifi_accno='8320' WHERE accno='5710';
UPDATE chart SET accno='8330', gifi_accno='8330' WHERE accno='5720';
UPDATE chart SET accno='8340', gifi_accno='8340' WHERE accno='5730';
UPDATE chart SET accno='8350', gifi_accno='8350' WHERE accno='5740';
UPDATE chart SET accno='8360', gifi_accno='8360' WHERE accno='5750';
UPDATE chart SET accno='8370', gifi_accno='8370' WHERE accno='5760';
UPDATE chart SET accno='8380', gifi_accno='8380' WHERE accno='5770';
UPDATE chart SET accno='8390', gifi_accno='8390' WHERE accno='5780';
UPDATE chart SET accno='8400', gifi_accno='8400' WHERE accno='94800';
UPDATE chart SET accno='8890', gifi_accno='8890' WHERE accno='5790';
-- 5800 -> 8900
UPDATE chart SET accno='8900', gifi_accno='8900' WHERE accno='5800';
UPDATE chart SET accno='8910', gifi_accno='8910' WHERE accno='5810';
UPDATE chart SET accno='8920', gifi_accno='8920' WHERE accno='5820';
UPDATE chart SET accno='8930', gifi_accno='8930' WHERE accno='5830';
-- 
-- 4400 -> 5800
UPDATE chart SET accno='5800', gifi_accno='5800' WHERE accno='4400';
UPDATE chart SET accno='5810', gifi_accno='5810' WHERE accno='4410';
-- set currency gain/loss accounts
DELETE from defaults WHERE fldname='fxgain_accno_id';
DELETE from defaults WHERE fldname='fxloss_accno_id';
INSERT INTO defaults (fldname, fldvalue) VALUES ('fxgain_accno_id', (SELECT id FROM chart WHERE accno = '6520'));
INSERT INTO defaults (fldname, fldvalue) VALUES ('fxloss_accno_id', (SELECT id FROM chart WHERE accno = '7110'));
-- change translations
