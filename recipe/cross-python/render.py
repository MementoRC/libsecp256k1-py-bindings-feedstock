# FORK-ONLY smoke test helper: fill in the cross-python activation template
# the way cross-python's build.sh does, using the build python (which has the
# same version and free-threading flavour as the target python).
import sys
import sysconfig

src, dst = sys.argv[1:3]
ver = "%d.%d" % sys.version_info[:2]
values = {
    "@CROSS_TARGET_PLATFORM@": "win-arm64",
    "@PLAT_TAG@": "win_arm64",
    "@PY_VER_NODOT@": ver.replace(".", ""),
    "@PY_VER@": ver,
    "@PY_THREAD@": "t" if sysconfig.get_config_var("Py_GIL_DISABLED") else "",
}
with open(src) as f:
    text = f.read()
for key, value in values.items():
    text = text.replace(key, value)
with open(dst, "w") as f:
    f.write(text)
