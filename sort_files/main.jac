node file { has name; has filename_score; has file_type_score; has folders; has file_type; }
node folder {has file; has name;}

walker init{
	has sorted_files = {}, sorted_folders = {}, file_data = ".jaseci_output.txt";
	can use.enc_question, use.enc_answer;
		
	root{ 
		folders = []; folder_names = file.load_str("./.folders.txt").str::split("****");
		files = []; file_names = file.load_str("./.files.txt").str::split("\n");
		file_types = []; file_type_input = file.load_str("./.file_types.txt").str::split("\n");
		for folder in folder_names: folders.l::append(folder.str::replace("\n", "")); folders.l::remove("");
		for file in file_names: files.l::append(file); files.l::remove("");
		for file_type in file_type_input: file_types.l::append(file_type); file_types.l::remove("");
		for i=0 to i<files.length by i+=1: here --> spawn node::file(name = files[i], folders=folders, file_type=file_types[i]); take -->;
	}
	file{
		que_fn_enc = use.enc_question(here.name);
		que_ft_enc = use.enc_question(here.file_type);
    	ans_enc = use.enc_answer(here.folders);
		max_score = 0; threshold = 0.03; chosen_folder = ""; total_score = 0;
		for i = 0 to i<here.folders.length by i+=1{
			here.filename_score = vector.cosine_sim(que_fn_enc, ans_enc[i]);
			here.file_type_score = vector.cosine_sim(que_ft_enc, ans_enc[i]);
			total_score = here.filename_score + here.file_type_score;
			if ( total_score > max_score && total_score >= threshold ){
				max_score = total_score;
				chosen_folder = here.folders[i];
			}
		}
		if ( here.name not in sorted_files ): sorted_files[here.name.str] = chosen_folder.str;
		spawn here --> node::folder(name=chosen_folder, file=here.name);
	}
	with exit{ file.dump_json(file_data, sorted_files); }
}
