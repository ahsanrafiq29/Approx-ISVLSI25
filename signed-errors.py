import numpy as np

# Function to load exact and approximate results
def load_results(exact_file, approx_file):
    # Use int32 to handle signed integer values correctly
    exact = np.loadtxt(exact_file, dtype=np.float64).astype(np.int32)
    approx = np.loadtxt(approx_file, dtype=np.float64).astype(np.int32)

    if len(exact) != len(approx):
        raise ValueError("Exact and approximate result files must have the same number of entries.")
    return exact, approx

# Function to compute error metrics
def calculate_error_metrics(exact, approx):
    num_combinations = len(exact)

    # Compute absolute error distances
    error_distances = np.abs(approx - exact)
    total_error = np.sum(error_distances)
    wce = np.max(error_distances)
    mse = np.mean((approx - exact) ** 2)

    # Avoid division by zero for relative errors
    relative_errors = np.zeros_like(exact, dtype=np.float64)
    non_zero_mask = exact != 0
    relative_errors[non_zero_mask] = error_distances[non_zero_mask] / np.abs(exact[non_zero_mask])

    mean_relative_error = np.mean(relative_errors[non_zero_mask]) if np.any(non_zero_mask) else float('nan')
    num_mismatches = np.sum(approx != exact)

    # Mean Absolute Error (MAE)
    mae = total_error / num_combinations

    # Mean Absolute Error Percentage (MAE%)
    mae_percent = (mae / np.max(np.abs(exact))) * 100

    # Worst-Case Error (WCE) Percentage
    wce_percent = (wce / np.max(np.abs(exact))) * 100

    # Worst-Case Relative Error (WCRE%)
    min_non_zero_exact = np.min(np.abs(exact[non_zero_mask])) if np.any(non_zero_mask) else float('nan')
    wcre_percent = (wce / min_non_zero_exact) * 100 if not np.isnan(min_non_zero_exact) else float('nan')

    # Error Probability (EP)
    ep_percent = (num_mismatches / num_combinations) * 100

    # Normalized Mean Error Distance (NMED)
    nmed = mae / 65536  # Adjusted for signed 8x8 range

    # Mean Relative Error Distance (MRED)
    total_relative_error_distance = np.sum(relative_errors[non_zero_mask])  
    mred = total_relative_error_distance / num_combinations

    return {
        'MAE': mae,
        'MAE%': mae_percent,
        'WCE': wce,
        'WCE%': wce_percent,
        'WCRE%': wcre_percent,
        'EP%': ep_percent,
        'MRE%': mean_relative_error * 100 if not np.isnan(mean_relative_error) else float('nan'),
        'MSE': mse,
        'NMED': nmed,
        'MRED': mred
    }

def main(exact_file, approx_file):
    # Load results from files
    exact, approx = load_results(exact_file, approx_file)

    # Calculate error metrics
    metrics = calculate_error_metrics(exact, approx)

    # Output the results
    print(f"Mean Absolute Error (MAE): {metrics['MAE']:.6f}")
    print(f"Mean Absolute Error Percentage (MAE%): {metrics['MAE%']:.2f}%")
    print(f"Worst-Case Error (WCE): {metrics['WCE']:.6f}")
    print(f"Worst-Case Error Percentage (WCE%): {metrics['WCE%']:.2f}%")
    print(f"Worst-Case Relative Error (WCRE%): {metrics['WCRE%']:.2f}%")
    print(f"Error Probability (EP%): {metrics['EP%']:.2f}%")
    print(f"Mean Relative Error (MRE%): {metrics['MRE%']:.2f}%")
    print(f"Mean Squared Error (MSE): {metrics['MSE']:.2f}")
    print(f"Normalized Mean Error Distance (NMED): {metrics['NMED']:.6f}")
    print(f"Mean Relative Error Distance (MRED): {metrics['MRED']:.6f}")

# Example usage
if __name__ == "__main__":
    exact_file = r'D:\Beyond_Entrusted\not_approved_designs\0\op8x8.txt'
    approx_file = r'E:\ISVLSI-Unsigned\Error Codes\signed_convert.txt'
    main(exact_file, approx_file)
