//
//  MQTTAppState.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 14/04/2023.
//

import Combine
import Foundation

enum MQTTAppConnectionState {
	case connected
	case disconnected
	case connecting
	case connectedSubscribed
	case connectedUnSubscribed

	var description: String {
		switch self {
		case .connected:
			return "Connected"
		case .disconnected:
			return "Disconnected"
		case .connecting:
			return "Connecting"
		case .connectedSubscribed:
			return "Subscribed"
		case .connectedUnSubscribed:
			return "Connected Unsubscribed"
		}
	}
	var isConnected: Bool {
		switch self {
		case .connected, .connectedSubscribed, .connectedUnSubscribed:
			return true
		case .disconnected,.connecting:
			return false
		}
	}
	
	var isSubscribed: Bool {
		switch self {
		case .connectedSubscribed:
			return true
		case .disconnected,.connecting, .connected,.connectedUnSubscribed:
			return false
		}
	}
}

final class MQTTAppState: ObservableObject {
	@Published var appConnectionState: MQTTAppConnectionState = .disconnected
	@Published var receivedMessage: String = ""
	@Published var tempMessage: String = ""
	@Published var lightMessage: Bool = false
	@Published var doorMessage: Bool = false

	func setReceivedMessage(text: String) {
		if text.contains("temp") {
			tempMessage = text.replacingOccurrences(of: "temp: ", with: "")
		}
		if text.contains("light") {
			var temp = text.replacingOccurrences(of: "light:", with: "")
			if (temp == "1") {
				lightMessage = true //on
			}
		}
		if text.contains("door") {
			var temp = text.replacingOccurrences(of: "door:", with: "")
			if (temp == "1") {
				doorMessage = true //locked
			}
		}
	}

	func clearData() {
		receivedMessage = ""
	}

	func setAppConnectionState(state: MQTTAppConnectionState) {
		appConnectionState = state
	}
}
