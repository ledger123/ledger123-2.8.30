-- Japanese COA General Purpose - Version 02
-- First Choice Internet Ltd., B.Plagge, 05 Oct. 2007
-- 2010-03-23: bplagge - setup costs corrected as expenses, some additional expense accounts
-- Delete account translations and reload

DELETE FROM translation WHERE language_code='ja_JP';

-- account translations Japanese
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1000'),'ja_JP','資産の部');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1010'),'ja_JP','土地 ');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1020'),'ja_JP','蓄積土地の償却');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '10329'),'ja_JP','資本金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1100'),'ja_JP','建物');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1110'),'ja_JP','蓄積建物の償却');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1120'),'ja_JP','附属設備');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1130'),'ja_JP','蓄積附属設備 の償却');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1140'),'ja_JP','車両運搬具');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1150'),'ja_JP','蓄積減価償却車両運搬具');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1160'),'ja_JP','機械装置');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1170'),'ja_JP','減価償却機械装置');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1180'),'ja_JP','工具器具備品');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1190'),'ja_JP','減価償却工具器具備品');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1300'),'ja_JP','許可と他の資産');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1310'),'ja_JP','電話加入権');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1320'),'ja_JP','施設利用権');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1330'),'ja_JP','工業所有権');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1340'),'ja_JP','営業権');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1350'),'ja_JP','借地権');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1360'),'ja_JP','有価証券');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1370'),'ja_JP','定期預金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1380'),'ja_JP','定期積金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1400'),'ja_JP','差入保証金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1900'),'ja_JP','在庫資産');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1910'),'ja_JP','商品在庫');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1920'),'ja_JP','原材料在庫');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1930'),'ja_JP','貯蔵品在庫');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1940'),'ja_JP','製品在庫');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1950'),'ja_JP','商品棚卸高');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1960'),'ja_JP','副産物作業くず在庫');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2000'),'ja_JP','流動資産計');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2010'),'ja_JP','普通預金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2020'),'ja_JP','当座預金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2030'),'ja_JP','現金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2040'),'ja_JP','小口現金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2050'),'ja_JP','通知預金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2100'),'ja_JP','売掛金と決済');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2110'),'ja_JP','売掛金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2120'),'ja_JP','受取手形');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2120'),'ja_JP','貸し倒れ');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2130'),'ja_JP','未収収益');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2160'),'ja_JP','短期貸付金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2170'),'ja_JP','立替金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2180'),'ja_JP','前払費用');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2190'),'ja_JP','仮払金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3000'),'ja_JP','流動負債計');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3010'),'ja_JP','買掛金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3020'),'ja_JP','支払手形');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3040'),'ja_JP','不渡手形');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3050'),'ja_JP','退職給与繰入額');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3060'),'ja_JP','未払費用');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3070'),'ja_JP','未払法人税等');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3080'),'ja_JP','未払事業税等');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3090'),'ja_JP','未払い利息 ');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3110'),'ja_JP','未払配当金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3120'),'ja_JP','未払役員賞与');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3130'),'ja_JP','未払役員の手当');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3140'),'ja_JP','未払い株主決済');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3150'),'ja_JP','預り金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3160'),'ja_JP','繰延税金負債');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3170'),'ja_JP','短期借入金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3180'),'ja_JP','試験研究費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3190'),'ja_JP','仮受金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3200'),'ja_JP','割引手形');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3210'),'ja_JP','裏書手形');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3220'),'ja_JP','前受金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3240'),'ja_JP','払消費税');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3250'),'ja_JP','源泉徴収税5% ');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3260'),'ja_JP','受消費税(5%)');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3500'),'ja_JP','固定負債計');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3510'),'ja_JP','預り保証金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3520'),'ja_JP','前受収益');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3530'),'ja_JP','長期借入金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3540'),'ja_JP','不動産抵当貸付');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3550'),'ja_JP','長期未払金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3560'),'ja_JP','退職給与引当金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4010'),'ja_JP','資本金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4020'),'ja_JP','自己株式');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4030'),'ja_JP','株式評価差額金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4100'),'ja_JP','引当金 ');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4110'),'ja_JP','貸倒引当金(投)');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4120'),'ja_JP','別段預金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4130'),'ja_JP','別途積立金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4140'),'ja_JP','損失引当金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4150'),'ja_JP','維持引当金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4160'),'ja_JP','資本準備金 ');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4170'),'ja_JP','賃倒引当金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4180'),'ja_JP','製品保証引当金');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '5000'),'ja_JP','利益(損害)');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '5010'),'ja_JP','当期末経費控除後利益');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '5020'),'ja_JP','未処理利益');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '5800'),'ja_JP','中級勘定 ');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '5810'),'ja_JP','期首残高の中級計算');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7500'),'ja_JP','給与費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7510'),'ja_JP','給料手当');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7520'),'ja_JP','役員報酬');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7530'),'ja_JP','賞与');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7540'),'ja_JP','法定福利費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7550'),'ja_JP','福利厚生費 ');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7560'),'ja_JP','退職金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7570'),'ja_JP','外注費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7580'),'ja_JP','採用教育費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7590'),'ja_JP','雑給');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7600'),'ja_JP','役員の手当 ');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6000'),'ja_JP','営業損益の部');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6010'),'ja_JP','売上高');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6020'),'ja_JP','役務収益');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6030'),'ja_JP','売上値引高 ');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6040'),'ja_JP','仕入値引高');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6500'),'ja_JP','その他の売上高');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6510'),'ja_JP','受取利息');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6520'),'ja_JP','外通貨利益');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6530'),'ja_JP','有価証券売却益');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6540'),'ja_JP','固定資産売却益');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6550'),'ja_JP','受配当金(総)');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6560'),'ja_JP','雑収入');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7000'),'ja_JP','売上原価');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7010'),'ja_JP','追加間接販売減価');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7020'),'ja_JP','販売減価 販売');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7030'),'ja_JP','仕入高');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7040'),'ja_JP','追加仕入費');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7100'),'ja_JP','特別費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7110'),'ja_JP','外通貨損害 ');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7120'),'ja_JP','有価証券売却損');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7130'),'ja_JP','固定資産売却損');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7140'),'ja_JP','貸倒損失(営)');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7150'),'ja_JP','雑損失');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7160'),'ja_JP','在庫棚卸高 ');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7170'),'ja_JP','貸倒損失(販)');
-- n
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7300'),'ja_JP','一般管理費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7310'),'ja_JP','減価償却建物');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7320'),'ja_JP','減価償却機械装置');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7350'),'ja_JP','減価償却車両運搬具');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7360'),'ja_JP','減価コンピュータ費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7370'),'ja_JP','長前費用償却');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7380'),'ja_JP','減価償却費');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7200'),'ja_JP','法定準備金計');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7210'),'ja_JP','創立費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7220'),'ja_JP','開業費');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7800'),'ja_JP','税額');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7810'),'ja_JP','法人税等');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7820'),'ja_JP','法人税等調整額');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7830'),'ja_JP','租税公課');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8000'),'ja_JP','一般的管理外費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8010'),'ja_JP','保険料');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8020'),'ja_JP','研究開発費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8030'),'ja_JP','車両費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8040'),'ja_JP','実施料とソフト');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8050'),'ja_JP','リース料');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8060'),'ja_JP','修繕費');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8200'),'ja_JP','管理費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8210'),'ja_JP','地代家賃');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8220'),'ja_JP','水道光熱費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8230'),'ja_JP','旅費交通費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8240'),'ja_JP','情報システム');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8250'),'ja_JP','事務用品費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8260'),'ja_JP','通信費 ');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8270'),'ja_JP','新聞図書費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8280'),'ja_JP','会議費 ');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8290'),'ja_JP','交際費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8300'),'ja_JP','広告宣伝費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8310'),'ja_JP','荷造運賃発送費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8320'),'ja_JP','会費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8330'),'ja_JP','支払手数料 ');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8340'),'ja_JP','寄付金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8350'),'ja_JP','諸会費 ');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8360'),'ja_JP','一般管理費 ');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8370'),'ja_JP','消耗品 ');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8380'),'ja_JP','その他サービス');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8390'),'ja_JP','会社間経費');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8400'),'ja_JP','支払利息');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8890'),'ja_JP','雑費');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8900'),'ja_JP','調整');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8910'),'ja_JP','現金違');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8920'),'ja_JP','在庫違');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8930'),'ja_JP','特別費用 & 利益');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '9000'),'ja_JP','利益計算');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '9850'),'ja_JP','中配当積立取崩');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '9860'),'ja_JP','中間配当額');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '9870'),'ja_JP','利益準備金積立');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '9880'),'ja_JP','前期繰越損益');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '9900'),'ja_JP','末間配当額 ');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '9999'),'ja_JP','当期未処分損益');


DELETE FROM translation WHERE language_code='zh_CN';

-- account translations simplified Chinese
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1000'),'zh_CN','固定资产');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1010'),'zh_CN','土地');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1020'),'zh_CN','累计推销土地');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1100'),'zh_CN','房屋及建筑');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1110'),'zh_CN','累计推销房屋');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1120'),'zh_CN','辅助设备');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1130'),'zh_CN','辅助设备折旧');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1140'),'zh_CN','机动车辆');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1150'),'zh_CN','累积折旧车辆');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1160'),'zh_CN','机(器)具及设备');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1170'),'zh_CN','折旧机(器)具及设备');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1180'),'zh_CN','软件');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1190'),'zh_CN','累积折旧工具');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1300'),'zh_CN','执照和其他资产');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1320'),'zh_CN','设备/设施许可证');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1330'),'zh_CN','工业生产许可证');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1340'),'zh_CN','销售许可证');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1350'),'zh_CN','租赁许可');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1360'),'zh_CN','证券');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1370'),'zh_CN','固定存款帐户');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1380'),'zh_CN','固定定期存款');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1400'),'zh_CN','已付保证金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1900'),'zh_CN','存量资产');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1910'),'zh_CN','待销产品');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1920'),'zh_CN','原料存货');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1930'),'zh_CN','辅助材料存货');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1940'),'zh_CN','成品存货');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1950'),'zh_CN','贸易产品');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '1960'),'zh_CN','副产品');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2000'),'zh_CN','流动资产');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2010'),'zh_CN','普通银行户头');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2020'),'zh_CN','现银行户头');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2030'),'zh_CN','现金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2040'),'zh_CN','零用金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2050'),'zh_CN','储蓄存款帐户(通知)');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2100'),'zh_CN','已收与支付');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2110'),'zh_CN','应收帐款');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2120'),'zh_CN','应收票据');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2130'),'zh_CN','未收所得');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2140'),'zh_CN','可疑债务');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2160'),'zh_CN','应收短期贷款');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2170'),'zh_CN','预付款');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2180'),'zh_CN','预支费用');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '2190'),'zh_CN','临时预支');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3000'),'zh_CN','流动负债');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3010'),'zh_CN','应付帐款');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3020'),'zh_CN','已付票据');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3040'),'zh_CN','拒付票据');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3050'),'zh_CN','应付工资');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3060'),'zh_CN','应付支出');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3070'),'zh_CN','应付公司所得税');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3080'),'zh_CN','应付企业税');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3090'),'zh_CN','应付利息');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3110'),'zh_CN','应付股利');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3120'),'zh_CN','应付行政津贴');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3130'),'zh_CN','应付薪水');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3140'),'zh_CN','未清股东应付帐');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3150'),'zh_CN','员工税剩余');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3160'),'zh_CN','递延所得税负债');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3170'),'zh_CN','短期债务');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3180'),'zh_CN','实验与研究支出');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3190'),'zh_CN','暫收款');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3200'),'zh_CN','应收票据贴现');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3210'),'zh_CN','票据背书');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3220'),'zh_CN','已收预付款');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3240'),'zh_CN','购买增值税(5%)');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3250'),'zh_CN','预扣所得税(5%)');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3260'),'zh_CN','销售增值税(5%)');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3500'),'zh_CN','长期借款');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3510'),'zh_CN','已收保证金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3520'),'zh_CN','预收收入');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3530'),'zh_CN','长期债务');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3540'),'zh_CN','不动产抵押贷款');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3550'),'zh_CN','长期应付款额');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '3560'),'zh_CN','退休金准备');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4000'),'zh_CN','股本');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4010'),'zh_CN','公司资本');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4020'),'zh_CN','持有股票');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4030'),'zh_CN','股票市值变化');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4100'),'zh_CN','储备金和准备金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4110'),'zh_CN','不良债券准备金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4120'),'zh_CN','特种存款帐户');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4130'),'zh_CN','特别储备基金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4140'),'zh_CN','损失准备金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4150'),'zh_CN','维护准备金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4160'),'zh_CN','法律资本剩余');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4170'),'zh_CN','应收帐款准备金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '4180'),'zh_CN','担保准备金');
-- n
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '5000'),'zh_CN','盈余');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '5010'),'zh_CN','今年利润');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '5020'),'zh_CN','未分配利润');
 
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '5800'),'zh_CN','期内帐单');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '5810'),'zh_CN','期内计算期初余额');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7500'),'zh_CN','薪金支出');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7510'),'zh_CN','工资');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7520'),'zh_CN','办公人员薪酬');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7530'),'zh_CN','红利');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7540'),'zh_CN','法律福利支出');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7550'),'zh_CN','福利支出');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7560'),'zh_CN','退休津贴');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7570'),'zh_CN','转包支出');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7580'),'zh_CN','员工培训支出');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7590'),'zh_CN','其他工资');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7600'),'zh_CN','津贴');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6000'),'zh_CN','普通业务利润');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6010'),'zh_CN','定期销售');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6020'),'zh_CN','服务销售');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6030'),'zh_CN','销售折扣');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6040'),'zh_CN','已收购买折扣');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6510'),'zh_CN','已收利息');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6520'),'zh_CN','外汇盈利');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6530'),'zh_CN','证券销售增益');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6540'),'zh_CN','固定资产销售增益');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6550'),'zh_CN','已收股利(毛利)');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '6560'),'zh_CN','其他收入');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7000'),'zh_CN','销货成本');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7010'),'zh_CN','间接销售成本附加费');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7020'),'zh_CN','常规销售产品成本');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7030'),'zh_CN','货物购入');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7040'),'zh_CN','附加购买成本');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7110'),'zh_CN','外汇亏损');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7120'),'zh_CN','证券销售亏损');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7130'),'zh_CN','固定资产销售亏损');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7140'),'zh_CN','坏帐损失');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7150'),'zh_CN','其他亏损');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7160'),'zh_CN','存货转销');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7170'),'zh_CN','不良债权转销');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7300'),'zh_CN','折旧');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7310'),'zh_CN','房屋折旧');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7320'),'zh_CN','折旧机(器)具及设备');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7350'),'zh_CN','机动车辆折旧');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7360'),'zh_CN','计算机折旧');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7370'),'zh_CN','老支出折旧');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7380'),'zh_CN','支出折旧');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7200'),'zh_CN','法律设置成本');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7210'),'zh_CN','创设费用');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7220'),'zh_CN','开办费用');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7800'),'zh_CN','税与关税');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7810'),'zh_CN','公司税');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7820'),'zh_CN','调整');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '7830'),'zh_CN','税与关税');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8010'),'zh_CN','保险成本');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8020'),'zh_CN','研究与开发支出');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8030'),'zh_CN','机动车辆费用');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8040'),'zh_CN','执照与软件');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8050'),'zh_CN','租赁成本');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8060'),'zh_CN','维修支出');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8200'),'zh_CN','管理成本');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8210'),'zh_CN','已付租金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8220'),'zh_CN','供热,照明,水费用');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8230'),'zh_CN','差旅费');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8240'),'zh_CN','信息系统'); 
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8250'),'zh_CN','办公用品');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8260'),'zh_CN','通讯支出');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8270'),'zh_CN','报纸杂志费用');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8280'),'zh_CN','会议支出');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8290'),'zh_CN','娱乐费用');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8300'),'zh_CN','广告费用');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8310'),'zh_CN','交通费用');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8320'),'zh_CN','会员费');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8330'),'zh_CN','银行费');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8340'),'zh_CN','赞助费');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8350'),'zh_CN','会计费');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8360'),'zh_CN','管理计费');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8370'),'zh_CN','消耗品');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8400'),'zh_CN','已付利息');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8890'),'zh_CN','其他费用');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8910'),'zh_CN','现金差异');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8920'),'zh_CN','存货差异');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '8930'),'zh_CN','特别成本与收益');

INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '9000'),'zh_CN','盈亏计算');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '9810'),'zh_CN','盈亏推后');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '9850'),'zh_CN','储备削减');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '9860'),'zh_CN','中期股利');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '9870'),'zh_CN','转入法定准备金');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '9900'),'zh_CN','股东股利');
INSERT INTO translation (trans_id,language_code,description) VALUES ((select id from chart where accno = '9999'),'zh_CN','现未分配盈亏(转)');
