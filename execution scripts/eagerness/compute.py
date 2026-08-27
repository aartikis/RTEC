import argparse

from utilities.compare import compare_ce, precision, recall, f1_score, get_micro, get_macro
from utilities.parser import parse_file, get_start_times, get_end_times


def parse_args():
    parser = argparse.ArgumentParser(description=""
                                                 "Compute eagerness, relative eagerness, "
                                                 "lateness and relative lateness"
                                                 "A report is printed on "
                                                 "the terminal as well as in an "
                                                 "output file.")

    parser.add_argument(
        '--rec',
        type=str,
        required=True,
        help='Path to the recognitions file.'
    )
    
    parser.add_argument(
        '--dt',
        type=str,
        required=True,
        help='Path to the dataset.'
    )
    
    parser.add_argument(
    	'--ex',
    	type=str,
    	required=False,
 	help='Path to file with ids to exclude. (Use with maritime Brest data to exclude vessel gaps.)'
    )
    
    parser.add_argument(
    	'--fm',
    	action='store_true',
    	required=False,
 	help='Exclude vehicle gaps. (Use in the fleet management example.)'
    )
    
    parser.set_defaults(fm=False)
    
    return parser.parse_args()

# Example usage
if __name__ == "__main__":
    args = parse_args()

    recs_file_path = args.rec
    dataset = args.dt
    fm = args.rec
    start_times = get_start_times(dataset)
    end_times = get_end_times(dataset)
    
    # print(start_times)
    excl_ids={}
    if args.ex is not None:
    	with open(args.ex, "r") as inp:
    		for line in inp:
    			excl_ids[line.rstrip()] = []
    			
    ces_gt = parse_file(recs_file_path, start_times, excl_ids, end_times, fm)


