from utilities.temporal_ops import temporal_intersection, temporal_difference

def precision(tp, fp):
    """
    Computes precision.

    :param tp: number of true positives
    :param fp: number of false poisitives
    :return: precision in [0,1]
    """
    if tp + fp == 0:
        return 0.0
    return tp / (tp + fp)

def recall(tp, fn):
    """

    :param tp:
    :param fn:
    :return:
    """
    if tp + fn == 0:
        return 0.0
    return tp / (tp + fn)

def f1_score(tp, fp, fn):
    """

    :param tp:
    :param fp:
    :param fn:
    :return:
    """
    p = precision(tp, fp)
    r = recall(tp, fn)
    if p + r == 0:
        return 0.0
    return 2 * p * r / (p + r)


def get_timepoints_from_intervals(interval_list):
    """

    :param interval_list:
    :return:
    """
    timepoints = 0
    for interval in interval_list:
        timepoints = timepoints + interval[1] - interval[0]
    return timepoints

def compare_ce(complex_event_gt, complex_event_test=None):
    """

    :param complex_event_gt:
    :param complex_event_test:
    :return:
    """
    tp = fp = fn = 0
    if complex_event_test is not None:
        for key in complex_event_gt:
            if key in complex_event_test:
                # true positives
                intersected = temporal_intersection(complex_event_gt[key],
                                                    complex_event_test[key])
                tp = tp + get_timepoints_from_intervals(intersected)

                # false positives (exist in test but not in gt)
                fp_diff = temporal_difference(complex_event_test[key], complex_event_gt[key])
                # if get_timepoints_from_intervals(fp_diff) > 0:
                        # print(key)
                        # print("Gt")
                        # print(complex_event_gt[key])
                        # print("test")
                        # print(complex_event_test[key])
                fp = fp + get_timepoints_from_intervals(fp_diff)
		
                # false negatives (exist in gt but not in test)
                fn_diff = temporal_difference(complex_event_gt[key], complex_event_test[key])

                # if get_timepoints_from_intervals(fn_diff) > 0:
                        # print(key)
                        # print("Gt")
                        # print(complex_event_gt[key])
                        # print("test")
                        # print(complex_event_test[key])
                fn = fn + get_timepoints_from_intervals(fn_diff)

            else:
                fn = fn + get_timepoints_from_intervals(complex_event_gt[key])

        for key in complex_event_test:
            if key not in complex_event_gt:
                fp = fp + get_timepoints_from_intervals(complex_event_test[key])
    else:
        for key in complex_event_gt:
            fn = fn + get_timepoints_from_intervals(complex_event_gt[key])

    result = {
        "tp": tp,
        "fp": fp,
        "fn": fn,
        "precision": precision(tp, fp),
        "recall": recall(tp, fn),
        "f1": f1_score(tp, fp, fn),
    }

    return result

def get_micro(results):
    micro_tp =  sum([results[ce]["tp"] for ce in results])
    micro_fp =  sum([results[ce]["fp"] for ce in results])
    micro_fn =  sum([results[ce]["fn"] for ce in results])
    micro_precision = precision(micro_tp, micro_fp)
    micro_recall = recall(micro_tp, micro_fn)
    micro_f1 = f1_score(micro_tp, micro_fp, micro_fn)

    result = {
        "tp": micro_tp,
        "fp": micro_fp,
        "fn": micro_fn,
        "precision": micro_precision,
        "recall": micro_recall,
        "f1": micro_f1,
    }

    return result

def get_macro(results):
    macro_tp = macro_fp = macro_fn = -1
    macro_precision =  sum([results[ce]["precision"] for ce in results])/len(results)
    macro_recall =  sum([results[ce]["recall"] for ce in results])/len(results)
    macro_f1 =  sum([results[ce]["f1"] for ce in results])/len(results)

    result = {
        "tp": macro_tp,
        "fp": macro_fp,
        "fn": macro_fn,
        "precision": macro_precision,
        "recall": macro_recall,
        "f1": macro_f1,
    }

    return result
