

def temporal_union(intervals1, intervals2):
    """
    Computes the temporal union between two lists of intervals
    Note: if infinity is included it should be math.inf.

    :param intervals1: a list of intervals
    :param intervals2: a list of intervals
    :return: the temporal union between intervals1 and intervals2
    """
    merged = []
    i, j = 0, 0
    intervals = []

    while i < len(intervals1) and j < len(intervals2):
        if intervals1[i][0] < intervals2[j][0]:
            intervals.append(intervals1[i])
            i += 1
        else:
            intervals.append(intervals2[j])
            j += 1

    # Append remaining intervals
    intervals.extend(intervals1[i:])
    intervals.extend(intervals2[j:])
    #print(intervals)
    # Now perform union in one scan
    for interval in intervals:
        if not merged or merged[-1][1] < interval[0]:
            merged.append(interval)
        else:
            merged[-1][1] = max(merged[-1][1], interval[1])

    return merged


def temporal_intersection(intervals1, intervals2):
    """

    :param intervals1:
    :param intervals2:
    :return:
    """
    i, j = 0, 0
    result = []

    while i < len(intervals1) and j < len(intervals2):
        a_start, a_end = intervals1[i]
        b_start, b_end = intervals2[j]

        # Find overlap between intervals
        start = max(a_start, b_start)
        end = min(a_end, b_end)

        if start < end:
            result.append([start, end])

        # Move the pointer with the smaller end time
        if a_end < b_end:
            i += 1
        else:
            j += 1

    return result


def temporal_difference(intervals1, intervals2):
    """

    :param intervals1:
    :param intervals2:
    :return:
    """
    result = []
    i, j = 0, 0

    while i < len(intervals1):
        a_start, a_end = intervals1[i]

        while j < len(intervals2) and intervals2[j][1] <= a_start:
            j += 1  # skip B intervals that end before A[i] starts

        curr_start = a_start

        while j < len(intervals2) and intervals2[j][0] < a_end:
            b_start, b_end = intervals2[j]

            if b_start > curr_start:
                result.append([curr_start, min(b_start, a_end)])

            curr_start = max(curr_start, b_end)

            if b_end >= a_end:
                break

            j += 1

        if curr_start < a_end:
            result.append([curr_start, a_end])

        i += 1

    return result

