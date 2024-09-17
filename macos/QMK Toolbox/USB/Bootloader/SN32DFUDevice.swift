import Foundation

class SN32DFUDevice: BootloaderDevice {
    override init(usbDevice: USBDevice) {
        super.init(usbDevice: usbDevice)
        name = "SN32 DFU"
        type = .sn32Dfu
    }

    override func flash(_ mcu: String, file: String) {
        guard file.lowercased().hasSuffix(".bin") else {
            print(message: "Only firmware files in .bin format can be flashed with sonixflasher!", type: .error)
            return
        }

        if productID == 0x7010 {
            runProcess("sonixflasher", args: ["-v", String(format: "%04X:%04X", vendorID, productID), "-o", "0x200", "-f", file])
        } else {
            runProcess("sonixflasher", args: ["-v", String(format: "%04X:%04X", vendorID, productID), "-f", file])
        }
    }
}
