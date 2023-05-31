//
//  Data.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 04/04/2023.
//

import Foundation

struct deviceName {
	static let AC_DEVICE = "AC"
	static let AC_DEVICE_FULL = "Air Conditioner"
	static let LIGHT_DEVICE = "Light"
	static let DOOR_DEVICE = "Door"
	static let TURN_OFF = "turn OFF?"
	static let TURN_ON = "turn ON?"
	static let LIGHT_STATE = "LightState"
	static let CAMERA_PACK = "CameraPack"
}

struct apiInfo {
	static let BASE_URL_API: String = "https://rndaedss.ddns.net/"
	static let POST_LOGIN_API: String = "api/v1/user" //no need token
	static let CHECK_EMAIL_API: String = "api/v1/user/checkemail"
	static let SEND_TOKEN_API: String = "api/v1/user/token"
	static let VALIDATE_TOKEN_API: String = "api/v1/user/validate"
	static let CHANGE_PASS_API: String = "api/v1/user/change"
	static let GET_ALL_ROOMS_API: String = "api/v1/room"
	static let GET_ALL_DEVICES_API: String = "api/v1/room/device/" //{roomName}
	static let GET_ALL_SCHEDULES_API: String = "api/v1/room/schedules/" //{roomName}
	static let POST_SCHEDULE_API: String = "api/v1/schedules"
	static let GET_CONFIG_API: String = "api/v1/config/" //{roomName}
	static let POST_CONFIG_API: String = "api/v1/config/"
	static let GET_SCHEDULER_DETAIL_API: String = "api/v1/scheduler"
	static let GET_YOLO_DETAIL_API: String = "api/v1/yolov5/" //{roomName}
}

struct mqttInfo {
//	static let BROKER = "tcp://rndaedss.ddns.net:1883"
	static let BROKER = "rndaedss.ddns.net"
	static let CLIENT_ID = "Android_MQTT_AEDSS"
	static let USERNAME_MQTT = "aws"
	static let PASSWORD_MQTT = "Rnd_AEDSS2023"
//	static let USERNAME_MQTT = "pi4"
//	static let PASSWORD_MQTT = "f8a41bcba1561a84f10af0d5851ce93b"

	static let REQUEST_DOOR = "requestDoorStatus"
	static let REQUEST_AC_ON = "requestACOn"
	static let REQUEST_AC_OFF = "requestACOff"
	static let REQUEST_LIGHT_ON = "requestLightOn"
	static let REQUEST_LIGHT_OFF = "requestLightOff"
	static let REQUEST_LIGHT_STATE = "requestLightState"
	static let REQUEST_AC_STATE = "requestTemp"
}

struct settings{
	static let IS_LOGGED_IN = "loggedin"
	static let AUTH = "auth"
	static let USERID = "userid"
	static let ROOM_LIST = "roomList"
	static let ROOM_NAME = "roomName"
	static let HAVE_CAMERA = "have CAMERA"
	static let HAVE_AC = "have AC"
	static let HAVE_LIGHT = "have LIGHT"
	static let HAVE_DOOR = "have DOOR"
	static let DEVICE_LIST = "deviceList"
	static let IS_TOKEN = "is token"
	static let IS_CHANGED_PASS = "is changed pass"
	
	static let AC_SUBSCRIBE_TOPIC = "AC_SUBSCRIBE_TOPIC"
	static let LIGHT_SUBSCRIBE_TOPIC = "LIGHT_SUBSCRIBE_TOPIC"
	static let DOOR_SUBSCRIBE_TOPIC = "DOOR_SUBSCRIBE_TOPIC"
	
	static let AC_PUBLISH_TOPIC = "AC_PUBLISH_TOPIC"
	static let LIGHT_PUBLISH_TOPIC = "LIGHT_PUBLISH_TOPIC"
	static let DOOR_PUBLISH_TOPIC = "DOOR_PUBLISH_TOPIC"
	
	static let LIGHT_AC_REQUEST_TOPIC = "LIGHT_AC_REQUEST_TOPIC"
	
	static let CAMERA_SUBSCRIBE_TOPIC = "CAMERA_SUBSCRIBE_TOPC"
	static let CAMERA_PUBLISH_TOPIC = "CAMERA_PUBLISH_TOPC"
	static let CAMERA_REQUEST_TOPIC = "CAMERA_REQUEST"
	
	static let HAVE_EMAIL = "HAVE EMAIL"
	static let CAMERA_CONFIG = "CAMERA CONFIG"
}

struct other{
	static let IMG_URL = "https://docs.google.com/uc?id="
}
