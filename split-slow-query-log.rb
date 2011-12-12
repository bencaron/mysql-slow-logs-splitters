#!/usr/bin/env ruby
#
#

outdir = "logs"
logpath = ARGV[0]
splitby = ARGV[1] || "month"

basepath = "./"
file = File.new(logpath, "r")

# Bogus starting file
currentdate = "none"
out = File.new("#{outdir}/main-log.log", "w")

while (line = file.gets)
    if line[0,1] == '#' and line[0,7] == "# Time:" then  
            logdate = line[8,6]
            # Same date?
            if logdate != currentdate then
                # New date... close file, reopen
                out.close
                out = File.new("#{outdir}/slow-log-#{logdate}.log", "a")
                currentdate = logdate
            end
    end
    out.write line
end
out.close
file.close
