#!/usr/bin/bash
# shellcheck shell=bash
# FOUND HERE
# https://stackoverflow.com/questions/6980090/how-to-read-from-a-file-or-standard-input-in-bash#7045517

$ cat > writer.sh << EOF
#!/bin/bash
echo "Execute PID $$" >> /dev/stderr
for i in {0..5}; do
  echo "line \${i}"
done
EOF

cat > reader.sh << EOF
#!/bin/bash
echo "Execute PID $$" >> /dev/stderr
while read -r line; do
  echo "reading: \${line}"
done < /dev/stdin
EOF


# make executable
chmod +x writer.sh

chmod +x reader.sh

 

# stdout|stdin

./writer.sh | ./reader.sh