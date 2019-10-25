library(stringr)

directory.raw = "21Bjurholm22Helluland23Hofn24Helvig25Blonduos26Vardo31Nelson32Arcadia34Kiyobico41Biruwa42Shinobi43Takazaki44Reading45Akkeshi46Hayarano51Pauma52Nidoma53Talu54Maeva55Colmar57Eden58Riroua59Gordes61Kinsale62Valais63Mahuti65Vaiku"


directory.list = str_split(directory.raw, "\\d+")
directory = directory.list[[1]][-1] #Delete blank first entry
directory
sort(directory)
