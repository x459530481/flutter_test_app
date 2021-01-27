
import 'package:event_bus/event_bus.dart';
export 'dart:async';
class EventBusUtil {
  static EventBus _eventBus;

  static EventBus getInstance() {
    if (_eventBus == null) {
      _eventBus = new EventBus();
    }
    return _eventBus;
  }
}

class ObjectEvent{
  ///首页更改显示页
  static int EVENT_TAG_SHOW_MAIN_TAB = 10000;
  static int EVENT_TAG_ON_RESUME = 9999;
  static int EVENT_TAG_ON_PAUSE = 9998;
  static int EVENT_TAG_AI_DEVICE_STATUS = 8999;//AI扫描设备状态
  static int EVENT_TAG_AI_BEGIN_SCAN = 8998;//AI扫描设备开始扫描
  static int EVENT_TAG_AI_END_SCAN = 8997;//AI扫描设备停止扫描
  static int EVENT_TAG_AI_SCAN_CODE_RESULT = 8996;//AI扫描码结果
  static int EVENT_TAG_AI_EXCEPTION_CODE= 8995;//AI扫描方式时  发送异常码数据
  static int EVENT_TAG_AI_CAMERA_EXCEPTION_CODE= 8994;//AI扫描方式时  CAMARA连接异常
  static int EVENT_TAG_AI_CONNECT_SUCCESS= 8993;//AI扫描方式时  连接成功
  static int EVENT_TAG_AI_CONNECT_FAIL= 8992;//AI扫描方式时  连接失败
  static int EVENT_TAG_AI_TEST_DATA= 8991;//AI接收的数据
  static int EVENT_TAG_AI_RUN_TIME_DATA= 8990;//AI接收的数据:运行的时间
  static int EVENT_TAG_AI_SHUT_DOWN = 8989;//AI扫描设备关闭工控机
  static int EVENT_TAG_LICENSE_CROP_IMG_SUCCESS = 1;//许可证图片剪切成功
  static int EVENT_TAG_BRAND_LOGO_CROP_IMG_SUCCESS = 2;//品牌logo图片剪切成功
  static int EVENT_TAG_CERTIFICATE_CROP_IMG_SUCCESS = 3;//商标注册证图片剪切成功
  static int EVENT_TAG_REASON_ADD_SUCCESS = 4;//添加原因成功
  static int EVENT_TAG_REASON_ADD_SUCCESS_FOR_RETURN = 5;//添加原因成功之后不返回列表页
  static int EVENT_TAG_ON_FORGET_PWD = 6;
  static int EVENT_TAG_SHOW_ALREADY_FINISH = 7;//提交成功之后返回列表显示已完成的单据列表
  static int EVENT_TAG_SHOW_EXECUTING_WORK_TASK = 8;//历史生产工单点击继续执行打开生产工单的执行中tab

  static int EVENT_TAG_SHOW_FLOW_ALREADY_FINISH = 10;//流向查询上报成功成功之后返回列表显示已完成的单据列表
  static int EVENT_TAG_OLD_BATCH_ASSIGN_REFERESH = 11;//批次赋码结束赋码之后  要回到已结束列表
  static int EVENT_TAG_BATCH_ASSIGN_REFERESH = 12;//批量赋码结束赋码之后  要回到已结束列表
  static int EVENT_TAG_COLSE_TAB = 13;//关闭当前页面
  static int EVENT_TAG_TRANSFER_SUCCESS= 14;//批量赋码和逐个赋码查看详情页转移成功

  static int EVENT_TAG_UPDATE_BOTTOM_WORD = 15;//多语言切换之后 唤醒首页底部的更新

  static int EVENT_TAG_SINGLE_ASSIGN_REFERESH = 16;//逐个赋码结束赋码之后  要回到已结束列表


  static int EVENT_TAG_PDA_SOCKET_DATA= 17;//生产工单pda 连接socket接受的数据
  static int EVENT_TAG_PDA_SOCKET_DATA2= 18;//生产工单pda 连接socket接受的数据
  static int EVENT_TAG_SHOW_ENABLE_PRDUCT = 19;//提交成功之后返回列表显示启用的产品
  static int EVENT_TAG_SHOW_ENABLE_FACTORY = 21;//提交成功之后返回列表显示启用的工厂
  static int EVENT_TAG_SHOW_ENABLE_WAREHOUSE = 22;//提交成功之后返回列表显示启用的仓库
  static int EVENT_TAG_SHOW_ENABLE_DEALER = 23;//提交成功之后返回列表显示启用的客户
  static int EVENT_TAG_SHOW_ENABLE_SUPPLIER = 24;//提交成功之后返回列表显示启用的印刷厂
  static int EVENT_TAG_PADUCT_UNIT_ADD_SUCCESS_FOR_RETURN = 25;//添加扫码单位成功之后不返回列表页

  static int EVENT_TAG_UPLOAD_SUCCESS_FOR_OFFLIN_ASSIGN= 26;//离线赋码上传成功

  static int EVENT_TAG_END_PACK= 27;//一二级称重赋码 结拍
  static int EVENT_TAG_NET_CONNECT_ERROR= 28;//网络无法连接
  static int EVENT_TAG_REF_ASSIGN_NO_UPLOAD_COUNT= 29;//称重扫码更新数量
  static int EVENT_TAG_REQUEST_ERROR_FOR_JOB= 30;//称重扫码job调用接口失败的异常信息
  static int EVENT_TAG_BIND_DEVICE= 31;//绑定设备id
  static int EVENT_TAG_SYNC_ALL_BASEDATA= 32;//全量同步数据
  static int EVENT_TAG_CHECK_VERSION= 33;//检查版本
  static int EVENT_TAG_REQUEST_REPRESH_FOR_JOB= 34;//称重扫码job通知页面刷新
  static int EVENT_TAG_REQUEST_REPRESH_FOR_OUT_TASK_JOB= 35;//出库任务单扫码job通知页面刷新产品信息item
  static int EVENT_UPDATE_COUNT_FOR_OUT_TASK_JOB= 36;//出库任务单扫码job通知页面刷新 未校验数
  // static int EVENT_TAG_ERROR_COUNT_FOR_OUT_TASK_JOB= 37;//出库任务单扫码job通知页面刷新 错误码数
  // static int EVENT_TAG_WAIT_DEAL_COUNT_FOR_OUT_TASK_JOB= 38;//出库任务单扫码job通知页面刷新 待处理数
  static int EVENT_TAG_NET_WORK_STATUS_FOR_OUT_TASK_JOB= 37;//出库任务单扫码job检查网络状态

  static int EVENT_TAG_TDC_DEVICE_STATUS = 8899;//TDC扫描设备状态
  static int EVENT_TAG_TDC_BEGIN_SCAN = 8898;//TDC扫描设备开始扫描
  static int EVENT_TAG_TDC_END_SCAN = 8897;//TDC扫描设备停止扫描
  static int EVENT_TAG_TDC_SCAN_CODE_RESULT = 8896;//TDC扫描码结果
  static int EVENT_TAG_TDC_EXCEPTION_CODE= 8895;//TDC扫描方式时  发送异常码数据
  static int EVENT_TAG_TDC_DVEICE_EXCEPTION_CODE= 8894;//TDC扫描方式时  CAMARA连接异常
  static int EVENT_TAG_TDC_CONNECT_SUCCESS= 8893;//TDC扫描方式时  连接成功
  static int EVENT_TAG_TDC_TEST_DATA= 8891;//TDC接收的数据
  static int EVENT_TAG_TDC_TEST_SEND_DATA= 8892;//TDC发送的数据
  static int EVENT_TAG_TDC_SCAN_CODE_ERROR_RESULT= 8890;//TDC扫描码结果 异常


  int tag;
  Object obj;
  ObjectEvent(this.tag,this.obj);
}

