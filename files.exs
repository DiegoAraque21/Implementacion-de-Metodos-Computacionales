# Function to work with files
#
# Diego Araque Fernandez
# 2022 - 05 - 03

defmodule Tfiles do

    def space_to_dash(in_filename, out_filename) do

    File.write(out_filename,Enum.join(Enum.map(Enum.map(File.stream!(in_filename), &String.split/1), fn line -> Enum.join(line, "-") end), "\n"))

    end

    def getEmails(in_filename, out_filename) do
      emails =
        in_filename
        |> File.stream!()
        |> Enum.map(&email_from_line/1)
        |> Enum.filter(&(&1 != nil))
        |> Enum.map(&hd/1)
        |> Enum.join("\n")
    File.write(out_filename, emails)
    end

    def email_from_line(line) do
      Regex.run(~r|\w+(?:\.\w+)*@\w+(?:\.\w+)*\.[a-z]{2,4}|, line)
    end
end
