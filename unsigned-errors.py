import numpy as np

# Function to load exact and approximate results
def load_results(exact_file, approx_file):
    exact = np.loadtxt(exact_file, dtype=np.uint16)  # Load as unsigned 16-bit integers
    approx = np.loadtxt(approx_file, dtype=np.uint16)  # Load as unsigned 16-bit integers
    
    if len(exact) != len(approx):
        raise ValueError("Exact and approximate result files must have the same number of entries.")
    
    return exact.astype(np.int32), approx.astype(np.int32)  # Convert to int32 to prevent overflow

# Function to compute error metrics
def calculate_error_metrics(exact, approx):
    num_combinations = len(exact)
    
    # Error distances
    error_distances = np.abs(approx - exact)
    total_error = np.sum(error_distances)
    wce = np.max(error_distances)
    mse = np.mean((approx - exact) ** 2)
    
    # Avoid division by zero for relative errors
    with np.errstate(divide='ignore', invalid='ignore'):
        relative_errors = np.zeros_like(error_distances, dtype=np.float32)
        valid_mask = exact != 0
        relative_errors[valid_mask] = error_distances[valid_mask] / exact[valid_mask]
    
    mean_relative_error = np.mean(relative_errors[valid_mask]) if np.any(valid_mask) else float('nan')
    num_mismatches = np.sum(approx != exact)
    
    # Mean Absolute Error (MAE)
    mae = total_error / num_combinations
    
    # Mean Absolute Error Percentage (MAE%)
    mae_percent = (mae / np.max(exact)) * 100 if np.max(exact) > 0 else float('nan')
    
    # Worst-Case Error (WCE)
    wce_percent = (wce / np.max(exact)) * 100 if np.max(exact) > 0 else float('nan')
    
    # Worst-Case Relative Error (WCRE%)
    min_non_zero_exact = np.min(exact[valid_mask]) if np.any(valid_mask) else float('nan')
    wcre_percent = (wce / min_non_zero_exact) * 100 if not np.isnan(min_non_zero_exact) and min_non_zero_exact > 0 else float('nan')
    
    # Error Probability (EP)
    ep_percent = (num_mismatches / num_combinations) * 100 if num_combinations > 0 else float('nan')
    
    # Error Rate (ER)
    er = num_mismatches / num_combinations if num_combinations > 0 else float('nan')
    
    # Mean Error Distance (MED)
    med = total_error / num_combinations
    
    # Normalized Mean Error Distance (NMED)
    nmed = (med / np.max(exact)) if np.max(exact) > 0 else float('nan')
    
    # Mean Relative Error Distance (MRED)
    mred = (np.mean(relative_errors[valid_mask]) * 100) if np.any(valid_mask) else float('nan')
    
    return {
        'MAE': mae,
        'MAE%': mae_percent,
        'WCE': wce,
        'WCE%': wce_percent,
        'WCRE%': wcre_percent,
        'EP%': ep_percent,
        'MRE%': mean_relative_error * 100 if not np.isnan(mean_relative_error) else float('nan'),
        'MSE': mse,
        'ER': er,
        'MED': med,
        'NMED': nmed,
        'MRED%': mred
    }

# Main function
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
    print(f"Error Rate (ER): {metrics['ER']:.6f}")
    print(f"Mean Error Distance (MED): {metrics['MED']:.6f}")
    print(f"Normalized Mean Error Distance (NMED): {metrics['NMED']:.6f}")
    print(f"Mean Relative Error Distance (MRED%): {metrics['MRED%']:.6f}%")

# Example usage
exact_file = r'C:\Users\ahsan\Downloads\For_ISVLSI\ISVLSI-Unsigned\Error Codes\op-exact8-un.txt'
approx_file = r'C:\Users\ahsan\Downloads\For_ISVLSI\ISVLSI-Unsigned\FINAL_TRY\op-esam2-up.txt'

main(exact_file, approx_file)
