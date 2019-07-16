require 'base64'

$default_icon = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr
								 0AAAAAXNSR0IArs4c6QAAAAlwSFlzAAALEwAACxMBAJ
								 qcGAAAAVlpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAA
								 Dx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0
								 YS8iIHg6eG1wdGs9IlhNUCBDb3JlIDUuNC4wIj4KICA
								 gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3Ln
								 czLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjI
								 j4KICAgICAgPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJv
								 dXQ9IiIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR
								 0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iPgogIC
								 AgICAgICA8dGlmZjpPcmllbnRhdGlvbj4xPC90aWZmO
								 k9yaWVudGF0aW9uPgogICAgICA8L3JkZjpEZXNjcmlw
								 dGlvbj4KICAgPC9yZGY6UkRGPgo8L3g6eG1wbWV0YT4
								 KTMInWQAACCdJREFUWAntVmuMVGcZfs53bnO/7czO7D
								 Iss7DQcsdKu1RssYXEpmpsU4mxRrGYoOkvo8SY6B9Nj
								 YkYIjb+MobQP8ZgIcQixVagFVqX+wLCXplZdhZ2534/
								 M+fqe8ZlWQRajP9M35lvzvV73+d93tsAn8j/AQPc/+L
								 Df7tZ6H+tf0Mi3v1sxB9Y63P5uyQmyKql1qpKLZUrlA
								 auXh5/d3D34MjDgnpoABtee+yrfUsT3+uJxfrj3THO5
								 /TBKcqQBRkGVChWHeVGGempmdrI6OThvw2c/mXut7nz
								 HwfkYwGEd4S7VqzsfX1x36KXemJhRHx++F0+uCQPvKI
								 fHOOgoUkAKlDMOnRTg95kSA6V60F14a92btl5FAIaBK
								 REq8BxXHU+qI8EEH810te1tPNAT9+C1TFfECu64ujwh
								 yBKDgi8BInJcHBuOJkXXtYBN/PBw4J07YEDTtQtBbl8
								 PtMbWnwEDCkyPEnrOq3LBCRHR8L2AIm9EotE+4Jverv
								 dqw2rBVE2INFyygJRH0QnvwgRfiH8LAIHc4OH2NZUVP
								 IYyg3hytQgLiYv4Gp6pLM4XRYGfnx2N0L0GuCjFbcsq
								 2Wz8SAAXMdi768DC71r/E4/Ni3ahL5AAi6HhF7HCnRL
								 SyByjjno2WoG51NncGLoGC5PXsSt0hRaegOCg6HZtMC
								 5+JdD3/ccLu6r/4E2Fcl4no5+WvcH4H5V+Lzcyb7mhA
								 vfWrMDW7qfh4N3gqPPbbFg4lzyLA6dOUCeXkSmehMaa
								 yIY8qB7cQDMEYQvKqNQVtFUDK7hrP6i+GL9rzgI2/ic
								 3I8BxoXwA40zuCXe5fhs+Fk4edfcBvvkyuQl7PnLbpw
								 aeR88aVjQ1YlEPAKByI2GgyioFVSaDRRrKgwT4HkKUI
								 QtkqP4ehPW66QiTitt67oHgOc70qO6pD9VKihw9XjhE
								 O5QbW+oKhX8fP/PcHL8OHoSXYguDKK7OwxeYpBdAqaL
								 BRSrdbQUHaZBjBEAXTOgNBpwheVtekU/I0C4QfGv2fq
								 Y/XOXhK2ndcbkbKmEq1NDSOVTdz2+nLqC8ZkxxBIhRB
								 /xQQhyVGMKuWIhXcihWFegtkyoDROGagEWQ7VZpTJVI
								 PrZmu37vqGR8anbSu2svEuELfx2XeQe1xoaqtRYavUK
								 3FRqqqri7OgZ/ObPe3C9PIrgAi8krwSOZ1BUHRpnotU
								 0wKhKbL+qtxQwMt5qtjBBTlgeE5bLZBeGLx0wBjB+2+
								 g9IYDLinIdDFyZIVPL4OC1P5HhAYiKA3k9h0KuiFhvB
								 xati6OcrVC2mwj5Awg7Q8hTM0qOp8F0HjIno1KrIJ2f
								 RMsu4wAD3wE4/WJ3i1rXbbkXgAKe1S2bOTCKYb5VgCo
								 pCPoC8Ig+9ES74A45QOTC56euSJlXVqtITt1CbrKEBV
								 YCL/S/iJAnhJPJ9/DGe3sp/gpM6oN25VrGbMOYRXAPA
								 EFjVatMtUsvcNRbGLXalqeJnDlDxxo6wiFYlHAaeRXo
								 DGADvxHHJ45hcHgYETOGnV/5EdYvWQ+KMzYtfQZhvhM
								 /PfgTGEXymmMwqjaUO3IXgMagFf/C3z9jDEwPgFeIAo
								 P20LvWDCWzx0KVr6KSqkAIM7ipFcsBAR+UTiI/WsPMs
								 IIdGzZhbe/atnHbhEN04rl1z2Pv8d9hZGbYnhumWWTU
								 iknxrMwBoO7kV2cQGB0b+6PoZttsjk0qoTYIwkJJDEs
								 kOBoHqwkoNzW0iipK6Qo06vCPBdfim0++AomAzRcmMz
								 CB9tHX0ripRk67a1TPAaBNISmK0fSxbDKwmU9KbtZrk
								 iGTp3yYrRUmcZBWAc20hgr54ZRFPBndiG3PbMcLq16C
								 T7a76x1RtRbeOX8UE9kJiEGe4m8exRFU7rwx24jIe5t
								 p218Vlyhp+/n9Upz7IaMhanIW3dTRUqm2s4BoObHMWI
								 6nlm/GFz/9JTyeeAIu2d3WaRFryew4RjNDtEPDufGze
								 OPUXrTEJgSZ1yiUe+cbt8/bDFDCEAbLBpDYunVr7e3D
								 bx9Sw8rL/k4p7uCc6HDE0EtteV20H+vj/Xi0e2U7y+0
								 wNfQ6xorXcG76HziWPIL3L51ATa+C1yWU63UYpFbsJO
								 8zeEvcm7gCjNnO0s5/i33RFgIgaJq2cnxkfF0hX1h4r
								 fjPzVan8rml4eVY1mEbDNtJTAZryDTTmGjSyC2fxcXM
								 aQIwhEIlD54yn7dEKFULjaqBVsuCQSE08rgpHAp+W5j
								 mLmTqGeKxzXbb7lwOEAs63RnctWtXheOEDSGXX64WLT
								 bIf/j0dek0GuUSMmoaN5UUchqNW1ZGxM2j6LTgp27oC
								 /jp35BF45eIFDWoZLhVN2DOcBXxhGePfMOVMWXq0fOM
								 2wjmGLAvZsVOuTgNjKU8pD7vc+aX+74rbImtlgROIwp
								 Mymr6OGnCyWRYo1KxY6/R2GvQACpRvRcrGkoVHY1RZN
								 lbnt+LQ67jmq+ZzGazKdJ9pw3SxT2zgO7Z8WlEohHT6
								 XKI3KinWL7M1TXe7HTEeLfDI0ASCR4B0Cl3Lbu5EPUG
								 zYKmpqNa01FMGWbthDAoHPDv42/JH+re1jgZv/Gfxun
								 6vgzY99sSDAb9oigmWENcRvSuEj+lPuHbqK30PcJFHV
								 EmSV76i8JzMDULSt5AKWWUq4MYa51xnGIT4geCzA3Xr
								 NpEuUzxm5d4s+rbh/uFYP7z9nkikXDUarUgl5NiRE/c
								 6NB6WJfZJQRNHydZzGxyDT3PT5tpMSXUpBRtuuVJcMV
								 UKkWd5KPloQA8QAXt3UpJYct+O7nmSqt965Ofh2TgX4
								 k6d3UEBImrAAAAAElFTkSuQmCC"

module Wired
	class Icon
		attr_accessor	:path
		attr_accessor	:string

		def initialize(options = {})
			@path 	= options[:path]
			@string = options[:string] || $default_icon

			@string = Base64.strict_encode64(File.open(@path, "rb").read).to_s if @path
		end


		def to_b64
			return @string if @string
			return nil
		end


		def to_bin
			@string.unpack('m*')[0]
		end
	end
end