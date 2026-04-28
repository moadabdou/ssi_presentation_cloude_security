import glob, os
files = ["plan.md"] + sorted(glob.glob("outputs/*")) + sorted(glob.glob("versions /*"))
out = open("all.md", "w")
for f in files:
  if os.path.isfile(f):
    out.write(f"## {f}\n\n")
    if f.endswith(".md"):
      out.write(open(f).read() + "\n\n")
    else:
      out.write(f"```text\n")
      out.write(open(f).read() + "\n")
      out.write("```\n\n")
out.close()
