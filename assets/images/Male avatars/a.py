import os

def list_files_in_directory(directory_path, output_file):
    try:
        # List all files in the given directory
        with open(output_file, 'w') as file:
            for filename in os.listdir(directory_path):
                file_path = os.path.join(directory_path, filename)
                if os.path.isfile(file_path):
                    file.write(filename + '\n')
        print(f"List of files written to {output_file}")
    except Exception as e:
        print(f"An error occurred: {e}")

# Example usage
directory_path = '../Male avatars'  # Replace with your folder path
output_file = 'file_list.txt'
list_files_in_directory(directory_path, output_file)
