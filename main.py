import calendar
import json
from datetime import datetime

data = {
    "AT&T": {
    },
    "IIJ": {},
    "NTT": {},
    "TINET": {}
}


def parse_data(key, open_file):
    while True:
        line = open_file.readline().strip()
        if len(line) == 0:
            break
        dt, cnt = line.split()
        dt = int(dt)
        cnt = int(cnt)
        dt = datetime.fromtimestamp(dt)
        day_num = dt.timetuple().tm_yday
        if data[key].get(dt.year) is None:
            data[key][dt.year] = {
                "list": [{
                    "00:00-08:00": 0,
                    "08:00-16:00": 0,
                    "16:00-24:00": 0,
                    "total": 0
                } for _ in range(0, 367)],
                "total": 0
            }
        year_dict = data[key][dt.year]
        active = data[key][dt.year]["list"][day_num]
        active["total"] += cnt
        year_dict["total"] += cnt
        if dt.hour < 8:
            active["00:00-08:00"] += cnt
            continue
        if dt.hour < 16:
            active["08:00-16:00"] += cnt
            continue
        active["16:00-24:00"] += cnt


if __name__ == '__main__':
    with open("ATT-ts-min") as open_file:
        parse_data("AT&T", open_file)
    with open("IIJ-ts-min") as open_file:
        parse_data("IIJ", open_file)
    with open("NTT-ts-min") as open_file:
        parse_data("NTT", open_file)
    with open("Tinet-ts-min") as open_file:
        parse_data("TINET", open_file)

    with open("year_days.json", "w") as open_file:
        json.dump(data, open_file)
