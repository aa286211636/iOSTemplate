

#ifndef APIDefine_h
#define APIDefine_h


//极光推送



//环境切换  打开Environment为发布环境地址  注释为测试环境地址
#define Environment


//基本url  填写测试和发布地址
#ifdef Environment
#define BASEURL_Login @"http://10.0.1.23:9000/prod-api"
#define BASEURL_HR  @"http://10.0.1.23:8080/hr/v2/api-docs"

#else
#define BASEURL_Login @"http://10.0.1.23:9000/prod-api"
#define BASEURL_HR  @"http://10.0.1.23:8080/hr/v2/api-docs"
#endif


//------------------登录模块----------------------
#define API_Login   @"/auth/login"
//登录

//------------------人事模块----------------------
//基本信息列表
#define API_BasicInformation_List   @"/hr/api/generate/EmployeeInformationPackage/StaffManagement/list"
//删除基本信息
#define API_BasicInformation_Del   @"/hr/api/generate/EmployeeInformationPackage/EmployeeBasicInformation/del"
//查询入职信息
#define API_BasicInformation_EnterInfo @"/hr/api/generate/EmployeeInformationPackage/EmployeeEntryInformation/getInfo"
//查询社保信息
#define API_BasicInformation_SocialInfo @"/hr/api/generate/EmployeeInformationPackage/SocialSecurity/getInfo"
//公积金基数列表
#define API_BasicInformation_SI_BaseList   @"/hr/api/generate/SocialInsurancePackage/SI_Base/allList"

#endif /* APIDefine_h */
