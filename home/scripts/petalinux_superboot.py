import argparse
import subprocess

"""
petalinux-boot 
    --qemu 
    --prebuilt 3 
    --qemu-args "-net nic -net nic -net nic -net nic,netdev=eth0 -netdev user,id=eth0,hostfwd=tcp::1114-:22,hostfwd=udp::10001-:10001"
"""

# Initialize parser
parser = argparse.ArgumentParser()
parser.add_argument(
    "-hf", 
    "--hostfwd", 
    help="Forward a port. Can be used multiple times. E.g., forward port 1114 to 22 using TCP: -hf tcp::1114-:22", 
    action="append"
)

# Read arguments from command line
args, unknown = parser.parse_known_args()

qemu_args = ""
if "--qemu-args" in unknown:
    i = unknown.index("--qemu-args")
    assert i + 1 < len(unknown), "Please provide arguments for --qemu-args"
    qemu_args = " ".join(unknown[i + 1:])
    unknown = unknown[:i]

if args.hostfwd:
    qemu_args += " -net nic -net nic -net nic -net nic,netdev=eth0 -netdev user,id=eth0,"
    hostfwd = [
        f"hostfwd={arg}"
        for arg in args.hostfwd
    ]
    hostfwd = ','.join(hostfwd)
    qemu_args += hostfwd
    qemu_args = qemu_args.strip()

run_args = [
    "petalinux-boot", 
    *unknown,
]

print_args = [a for a in run_args]
if qemu_args:
    run_args.extend(("--qemu-args", qemu_args))
    print_args.extend(("--qemu-args", f'"{qemu_args}"'))

print(" ".join(print_args))
subprocess.run(run_args)
