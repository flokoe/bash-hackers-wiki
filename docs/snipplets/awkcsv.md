# Using `awk` to deal with CSV that uses quoted/unquoted delimiters

---- dataentry snipplet ---- snipplet_tags : awk, csv
LastUpdate_dt : 2010-07-31 Contributors : SiegX (IRC) type : snipplet

------------------------------------------------------------------------

CSV files are a mess, yes.

Assume you have CSV files that use the comma as delimiter and quoted
data fields that can contain the delimiter.

    "first", "second", "last"
    "fir,st", "second", "last"
    "firtst one", "sec,ond field", "final,ly"

Simply using the comma as separator for `awk` won't work here, of
course.

Solution: Use the field separator `", "|^"|"$` for `awk`.

This is an OR-ed list of 3 possible separators:

  -------- -----------------------------------------------
  `", "`   matches the area between the datafields
  `^"`     matches the area left of the first datafield
  `"$`     matches the area right of the last data field
  -------- -----------------------------------------------

You can tune these delimiters if you have other needs (for example if
you don't have a space after the commas).

Test:

The `awk` command used for the CSV above just prints the fileds
separated by `###` to see what's going on:

    $ awk -v FS='", "|^"|"$' '{print $2"###"$3"###"$4}' data.csv
    first###second###last
    fir,st###second###last
    firtst one###sec,ond field###final,ly

**ATTENTION** If the CSV data changes its format every now and then (for
example it only quotes the data fields if needed, not always), then this
way will not work.
