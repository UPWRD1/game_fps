extends Label

var text_to_display := "Booting Kernel 5.10.0...
Loading initial ramdisk...

[    0.000000] ACPI: BIOS _OSI(Linux) system description tables
[    0.000000] ACPI: FACS 0x00000000D9F60F80 000040
[    0.000000] ACPI: DSDT 0x00000000D9F60C40 00393F (v02 OVERTR-K0   00000002 OVERTR-K0 20181115)
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x9f800 max_arch_pfn = 0x400000000
[    0.000000] Detected hardware: OVERTR-K0, CPU: OVERTR-Xk(7) @ 3.60GHz
[    0.000000] Secure boot enabled
[    0.000000] RAMDISK: [mem 0x365a7000-0x3727bfff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000D9F60F80 000024 (v02)
[    0.000000] ACPI: XSDT 0x00000000D9F60DE8 0000E4 (v01 00000002 OVERTR-K0 20181115)
[    0.000000] ACPI: FACP 0x00000000D9F79BC8 000114 (v06 00000002 OVERTR-K0 20181115)
[    0.000000] Initializing Cryptographic API
[    0.000000] Loading compiled-in X.509 certificates
[    0.000000] TPM version: 2.0
[    0.000000] TPM vendor-id: INTC
[    0.000000] TPM present, 2.0, 0x1
[    0.000000] efi: TPMFinalLog=0x9f4e1000 ACPI 2.0=0xd9f7b000 ACPI=0xd9f7b000 TPMEventLog=0xd9f52000
BIOS-provided physical RAM map:
 BIOS-e820: [mem 0x0000000000000000-0x000000000009dbff] usable
 BIOS-e820: [mem 0x000000000009dc00-0x000000000009ffff] reserved
 BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
 BIOS-e820: [mem 0x0000000000100000-0x000000007ffdffff] usable
 BIOS-e820: [mem 0x000000007ffe0000-0x000000007fffffff] reserved
 BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
 NX (Execute Disable) protection: active
SMBIOS 2.7 present.
DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-gec6b54c-prebuilt.qemu.org
tsc: Fast TSC calibration using PIT
tsc: Detected 2099.980 MHz processor
e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
last_pfn = 0x7ffe0 max_arch_pfn = 0x400000000
MTRR default type: uncachable
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-BFFFF uncachable
  C0000-FFFFF write-protect
MTRR variable ranges enabled:
  0 base 0x0E0000000 mask 0xFE0000000 uncachable
  1 base 0x0C0000000 mask 0xFC0000000 uncachable
  2 base 0x0B8000000 mask 0xFF8000000 uncachable
  3 base 0x0B4000000 mask 0xFFC000000 uncachable
  4 base 0x0B0000000 mask 0xFFE000000 uncachable
  5 base 0x0AE000000 mask 0xFFE000000 uncachable
  6 base 0x0AD000000 mask 0xFFF000000 uncachable
  7 base 0x0AC800000 mask 0xFFF800000 uncachable
  8 base 0x0AC400000 mask 0xFFFC00000 uncachable
  9 base 0x0AC200000 mask 0xFFFE00000 uncachable
 10 base 0x0AC100000 mask 0xFFFF00000 uncachable
 11 base 0x0AC080000 mask 0xFFFF80000 uncachable
 12 base 0x0AC000000 mask 0xFFFFC0000 uncachable
 13 base 0x0ABC00000 mask 0xFFFFC0000 uncachable
 14 base 0x0AC800000 mask 0xFFFFE0000 uncachable
 15 base 0x0AC400000 mask 0xFFFFF0000 uncachable
 16 base 0x0AC200000 mask 0xFFFFF8000 uncachable
 17 base 0x0AC100000 mask 0xFFFFFC000 uncachable
 18 base 0x0AC080000 mask 0xFFFFFC000 uncachable
 19 base 0x0AC000000 mask 0xFFFFFE000 uncachable
 20 base 0x0ABC00000 mask 0xFFFFFE000 uncachable
 21 base 0x0AC800000 mask 0xFFFFFF000 uncachable
 22 base 0x0AC400000 mask 0xFFFFFF800 uncachable
 23 base 0x0AC200000 mask 0xFFFFFFC00 uncachable
 24 base 0x0AC100000 mask 0xFFFFFFE00 uncachable
 25 base 0x0AC080000 mask 0xFFFFFFE00 uncachable
 26 base 0x0AC000000 mask 0xFFFFFFF00 uncachable
 27 base 0x0ABC00000 mask 0xFFFFFFF00 uncachable
 28 base 0x0AC800000 mask 0xFFFFFFF80 uncachable
 29 base 0x0AC400000 mask 0xFFFFFFFC0 uncachable
 30 base 0x0AC200000 mask 0xFFFFFFFC0 uncachable
 31 base 0x0AC100000 mask 0xFFFFFFFE0 uncachable
 32 base 0x0AC080000 mask 0xFFFFFFFE0 uncachable
 33 disabled
 34 disabled
 35 disabled
 36 disabled
 37 disabled
 38 disabled
 39 disabled
 40 disabled
 41 disabled
 42 disabled
 43 disabled
 44 disabled
 45 disabled
 46 disabled
 47 disabled
 48 disabled
 49 disabled
 50 disabled
 51 disabled
 52 disabled
 53 disabled
 54 disabled
 55 disabled
 56 disabled
 57 disabled
 58 disabled
 59 disabled
 60 disabled
 61 disabled
 62 disabled
 63 disabled
 64 disabled
found SMP MP-table at [mem 0x000fbd20-0x000fbd2f]
RAMDISK: [mem 0x7e769000-0x7fffffff]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000F0490 000014 (v00 BOCHS )
ACPI: RSDT 0x000000007FFE4160 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
ACPI: FACP 0x000000007FFE40C0 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
ACPI: DSDT 0x000000007FFE0040 001D19 (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
ACPI: FACS 0x000000007FFE0000 000040
ACPI: APIC 0x000000007FFE4180 000080 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
ACPI: HPET 0x000000007FFE4280 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
ACPI: WAET 0x000000007FFE42C0 000028 (v01 BOCHS  BXPCECWT 00000001 BXPC 00000001)
"
var typing_speed := 0.001  # Adjust the speed of typing

var current_text: String = ""
var typing_timer: float = 0.0

func _ready():
	# Initialize the label with an empty text
	text = ""

func _process(delta: float):
	typing_timer += 10

	if typing_timer >= typing_speed:
		typing_timer = 0.0

		# Add one character to the displayed text
		current_text = text_to_display.left(current_text.length() + 10)

		# Update the label text
		if text.length() == 50:
			text = ""
		else:
			text = current_text

		# Check if the entire text has been displayed
		if current_text == text_to_display:
			typing_speed = 0.0  # Typing is complete
