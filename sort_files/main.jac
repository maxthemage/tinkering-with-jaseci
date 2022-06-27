node file { has name; has score; has folders; }
node folder {has file; has name;}

walker init{
	has sorted_files = {}, sorted_folders = {}, file_data = ".jaseci_output.txt";
	can use.enc_question, use.enc_answer;
		
	root{ 
		folders = []; folder_names = file.load_str("./.folders.txt").str::split("****");
		files = []; file_names = file.load_str("./.files.txt").str::split("\n");
		for folder in folder_names: folders.l::append(folder.str::replace("\n", "")); folders.l::remove("");
		for file in file_names: files.l::append(file); files.l::remove("");
		for i=0 to i<files.length by i+=1: here --> spawn node::file(name = files[i], folders=folders); take -->;
	}
	file{
		que_enc = use.enc_question(here.name);
    	ans_enc = use.enc_answer(here.folders);
		max_score = 0; threshold = 0.03; chosen_folder = "";
		for i = 0 to i<here.folders.length by i+=1{
			here.score = vector.cosine_sim(que_enc, ans_enc[i]);
			if ( here.score > max_score && here.score >= threshold){
				max_score = here.score;
				chosen_folder = here.folders[i];
			}
		}
		if ( here.name not in sorted_files ): sorted_files[here.name.str] = chosen_folder.str;
		#if ( here.folder not in sorted_folders): sorted_folders[chosen_folder.str] = here.name.str;
		spawn here --> node::folder(name=chosen_folder, file=here.name);
	}
	#with exit { std.out(sorted_files); }
	with exit{ file.dump_json(file_data, sorted_files); }
}
