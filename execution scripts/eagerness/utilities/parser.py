from utilities.temporal_ops import temporal_union
import statistics
import re

def filter_outliers_iqr(values, k=1.5, min_size=4):
    """
    Remove outliers using the IQR rule.
    Values outside [Q1 - k*IQR, Q3 + k*IQR] are removed.

    - k=1.5 is the standard Tukey rule
    - min_size avoids filtering tiny samples

    vals = [v for v in values if isinstance(v, (int, float))]
    if len(vals) < min_size:
        return vals[:]  # not enough data to robustly identify outliers

    vals_sorted = sorted(vals)

    def median(seq):
        n = len(seq)
        mid = n // 2
        if n % 2 == 0:
            return (seq[mid - 1] + seq[mid]) / 2
        return seq[mid]

    n = len(vals_sorted)
    mid = n // 2

    if n % 2 == 0:
        lower = vals_sorted[:mid]
        upper = vals_sorted[mid:]
    else:
        lower = vals_sorted[:mid]
        upper = vals_sorted[mid + 1:]

    q1 = median(lower)
    q3 = median(upper)
    iqr = q3 - q1

    # If all values are basically identical, there are no outliers
    if iqr == 0:
        return vals[:]

    low = q1 - k * iqr
    high = q3 + k * iqr

    filtered = [v for v in vals if low <= v <= high]

    # Safety fallback: if everything gets removed, return original values
    return filtered if filtered else vals[:]
    """
    vals = [v for v in values if isinstance(v, (int, float))]
    if len(vals) < min_size:
        return vals[:]

def maximal_intervals_from_str(lomi_str):
    lomi_str = lomi_str.strip()
    if lomi_str == "":
        return []

    # Split top-level intervals: (a,b),(c,d)
    intervals = []
    buf = []
    depth = 0

    for ch in lomi_str:
        if ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1

        if ch == ',' and depth == 0:
            # separator between intervals
            part = "".join(buf).strip()
            if part:
                intervals.append(part)
            buf = []
        else:
            buf.append(ch)

    if buf:
        intervals.append("".join(buf).strip())

    # Now parse each "(x,y)"
    parsed = []
    for interval in intervals:
        if interval.startswith("(") and interval.endswith(")"):
            inside = interval[1:-1]

            # split x,y but ignore commas inside nested parentheses
            parts = []
            buf = []
            depth = 0
            for ch in inside:
                if ch == '(':
                    depth += 1
                elif ch == ')':
                    depth -= 1

                if ch == ',' and depth == 0:
                    parts.append("".join(buf).strip())
                    buf = []
                else:
                    buf.append(ch)
            if buf:
                parts.append("".join(buf).strip())

            # convert literal integers, keep everything else as strings
            def maybe_int(x):
                try:
                    return int(x)
                except ValueError:
                    return x

            if len(parts) == 2:
                parsed.append([maybe_int(parts[0]), maybe_int(parts[1])])

    return parsed


def maximal_intervals_to_str(lomi):
    output_str = "["
    for c in range(0, len(lomi)):
        start, finish = lomi[c]
        output_str += "(" + str(start) + "," + str(finish) + ")"
        if c < len(lomi) - 1:
            output_str += ","
    output_str += "]"
    return output_str


def split_top_level(s, sep=","):
    """
    Split string s on sep, but only at top level
    (i.e., not inside [] or ()).
    """
    parts = []
    buf = []
    depth = 0

    for ch in s:
        if ch in "([":
            depth += 1
        elif ch in ")]":
            depth -= 1

        if ch == sep and depth == 0:
            parts.append("".join(buf))
            buf = []
        else:
            buf.append(ch)

    if buf:
        parts.append("".join(buf))

    return parts


def parse_line(line):
    complex_event = {
        "name": "",
        "args": [],
        "value": "",
        "intervals": [],
        "to": -1,
    }

    line = line.strip()

    if not line.startswith("recognitions(") or not line.endswith(")."):
        raise ValueError(f"Unexpected line format: {line}")

    inner = line[len("recognitions("):-2]  # remove leading 'recognitions(' and trailing ').'

    # Top-level split by commas
    parts = [p.strip() for p in split_top_level(inner, ",")]

    if len(parts) < 4:
        raise ValueError(f"Not enough parts after splitting: {parts}")

    # CE name
    complex_event["name"] = parts[1]

    # --- Parse [[args], value] ---
    args_value_part = parts[2]
    if not (args_value_part.startswith("[") and args_value_part.endswith("]")):
        raise ValueError(f"Unexpected args/value format: {args_value_part}")

    # Drop outer [ ... ]
    inner_av = args_value_part[1:-1].strip()
    av_parts = split_top_level(inner_av, ",")

    args_part = av_parts[0].strip()
    value_part = av_parts[1].strip()

    if not args_part.startswith("["):
        raise ValueError(f"Unexpected args list: {args_part}")

    args_str = args_part[1:-1].strip()
    if args_str == "":
        args = []
    else:
        args = [a.strip() for a in split_top_level(args_str, ",")]

    complex_event["args"] = args
    complex_event["value"] = value_part

    # --- Parse intervals ---
    intervals_part = parts[3]
    if intervals_part == "[]":
        intervals_str = ""
    elif intervals_part.startswith("[") and intervals_part.endswith("]"):
        intervals_str = intervals_part[1:-1]
    else:
        raise ValueError(f"Unexpected intervals format: {intervals_part}")

    maximal_intervals_list = maximal_intervals_from_str(intervals_str)
    complex_event["intervals"] = maximal_intervals_list

    # --- Optional 'to' value ---
    if len(parts) >= 5:
        to_str = parts[4]
        try:
            complex_event["to"] = int(to_str)
        except ValueError:
            pass

    return complex_event


def last_report(intervals_list, fixed):
    """
    intervals_list: list like [[start1, end1], [start2, end2], ...]
    end can be int or string "plus(...)"
    fixed: fallback integer
    """
    if not intervals_list:
        return fixed

    for start, end in reversed(intervals_list):
        if isinstance(end, int):
            return end
        if isinstance(end, str) and not end.startswith("plus("):
            return end

    return fixed


def last_report_wplus(intervals_list, fixed):
    """
    intervals_list: list like [[start1, end1], [start2, end2], ...]
    end can be int or string "plus(...)"
    fixed: fallback integer
    """
    if not intervals_list:
        return fixed

    for start, end in reversed(intervals_list):
        if isinstance(end, int):
            return end
        if isinstance(end, str):
            return int(end.split("(")[1].rstrip(")"))

    return fixed


def compute_elrerl(last_report, last_reportw, to, tq):
    measures = {
        "e": -1,
        "l": -1,
    }
    measures["e"] = to - last_reportw
    measures["l"] = to - last_report
    return measures


def filter_outliers_iqr(values, k=1.5, min_size=4):
    """
    Remove outliers using the IQR rule.
    Values outside [Q1 - k*IQR, Q3 + k*IQR] are removed.

    - k=1.5 is the standard Tukey rule
    - min_size avoids filtering tiny samples
    """
    vals = [v for v in values if isinstance(v, (int, float))]
    if len(vals) < min_size:
        return vals[:]  # not enough data to robustly identify outliers

    vals_sorted = sorted(vals)

    def median(seq):
        n = len(seq)
        mid = n // 2
        if n % 2 == 0:
            return (seq[mid - 1] + seq[mid]) / 2
        return seq[mid]

    n = len(vals_sorted)
    mid = n // 2

    if n % 2 == 0:
        lower = vals_sorted[:mid]
        upper = vals_sorted[mid:]
    else:
        lower = vals_sorted[:mid]
        upper = vals_sorted[mid + 1:]

    q1 = median(lower)
    q3 = median(upper)
    iqr = q3 - q1

    # no spread => no outliers
    if iqr == 0:
        return vals[:]

    low = q1 - k * iqr
    high = q3 + k * iqr

    filtered = [v for v in vals if low <= v <= high]

    # fallback in case everything gets removed
    return filtered if filtered else vals[:]


def parse_file(file_path, start_times, excl_ids, end_times, fm):
    complex_events = {}
    complex_events_e = {}
    complex_events_l = {}
    total_measures_e = {}
    total_measures_l = {}
    total_measures_max_e = {}

    f = lambda s: s if s.isdigit() or "(" not in s else re.match(r'^[A-Za-z_]\w*\(([^,()]+)', s).group(1)

    with open(file_path, "r") as inp:
        for line in inp:
            if "Tq=" in line:
                query_time = int(line.split("=")[1])

                # Finalize previous Tq bucket
                if complex_events_e:
                    for key in complex_events_e:
                        # Filter ONLY eagerness values before computing stats
                        filtered_e = filter_outliers_iqr(complex_events_e[key])

                        # If everything was filtered out, skip safely
                        if not filtered_e:
                            continue

                        avg_e = statistics.mean(filtered_e)
                        avg_l = statistics.mean(complex_events_l[key]) if complex_events_l[key] else 0.0
                        max_e = max(filtered_e)

                        total_measures_e.setdefault(key, []).append(avg_e)
                        total_measures_l.setdefault(key, []).append(avg_l)
                        total_measures_max_e.setdefault(key, []).append(max_e)

                complex_events_e = {}
                complex_events_l = {}

            if "recognitions" in line:
                ce = parse_line(line)
                key = (ce["name"], ce["value"])
                args_key = tuple(ce["args"])
                ce_id = f(args_key[0])

                if ce_id in excl_ids:
                    continue

                if key not in complex_events:
                    complex_events[key] = {
                        args_key: [
                            last_report(ce["intervals"], start_times[ce_id]),
                            last_report_wplus(ce["intervals"], start_times[ce_id])
                        ]
                    }
                else:
                    if args_key in complex_events[key]:
                        complex_events[key][args_key][0] = last_report(
                            ce["intervals"], complex_events[key][args_key][0]
                        )
                        complex_events[key][args_key][1] = last_report_wplus(
                            ce["intervals"], complex_events[key][args_key][1]
                        )
                    else:
                        complex_events[key][args_key] = [
                            last_report(ce["intervals"], start_times[ce_id]),
                            last_report_wplus(ce["intervals"], start_times[ce_id])
                        ]
                if ce["to"] > 0:
                    if fm and ce["to"] >= end_times[ce_id]:
                        continue
                    if fm and ce["to"] - complex_events[key][args_key][0] > 86400:
                        continue
                    ce_arg_measures = compute_elrerl(
                        complex_events[key][args_key][0],
                        complex_events[key][args_key][1],
                        ce["to"],
                        query_time
                    )
                    complex_events_e.setdefault(key, []).append(ce_arg_measures["e"])
                    complex_events_l.setdefault(key, []).append(ce_arg_measures["l"])

    t_avg_e = 0
    t_avg_l = 0
    count = 0
    maxes = []

    for key in total_measures_e:
        # Filter eagerness aggregates again before final reporting
        filtered_total_e = filter_outliers_iqr(total_measures_e[key])
        filtered_total_max_e = filter_outliers_iqr(total_measures_max_e[key])

        if not filtered_total_e:
            continue

        avg_e = statistics.mean(filtered_total_e)
        std_e = statistics.stdev(filtered_total_e) if len(filtered_total_e) > 1 else 0.0

        avg_l = statistics.mean(total_measures_l[key]) if total_measures_l[key] else 0.0
        std_l = statistics.stdev(total_measures_l[key]) if len(total_measures_l[key]) > 1 else 0.0

        max_max_e = max(filtered_total_max_e) if filtered_total_max_e else 0.0
        maxes.append(max_max_e)

        t_avg_e += avg_e
        t_avg_l += avg_l
        count += 1

        removed = len(total_measures_e[key]) - len(filtered_total_e)

        print(f"--- Stats for: {key} ---")
        print(f"E avg: {avg_e:.3f}, std: {std_e:.3f}")
        print(f"E max: {max_max_e:.3f}")
        print(f"L avg: {avg_l:.3f}, std: {std_l:.3f}")
#        print(f"E outliers removed: {removed}")

    if count > 0:
        t_avg_e /= count
        t_avg_l /= count
    else:
        t_avg_e = 0.0
        t_avg_l = 0.0

    print(f"\n--- Avg E/L ---")
    print(f"E avg: {t_avg_e:.3f}, L avg: {t_avg_l:.3f}")
    print(f"E max avg: {max(maxes):.3f}")

    return complex_events


def get_start_times(file_path):
    starttimes = {}
    with open(file_path, "r") as inp:
        for line in inp:
            args = line.split("|")
            vessel = args[3].strip()
            time = int(args[2])
            if vessel not in starttimes:
                starttimes[vessel] = time
    return starttimes
    

def get_end_times(file_path):
    endtimes = {}
    with open(file_path, "r") as inp:
        for line in inp:
            args = line.split("|")
            vessel = args[3].strip()
            time = int(args[2])

            # keep the maximum time seen (latest end)
            if vessel not in endtimes:
                endtimes[vessel] = time
            else:
                endtimes[vessel] = max(endtimes[vessel], time)

    return endtimes

