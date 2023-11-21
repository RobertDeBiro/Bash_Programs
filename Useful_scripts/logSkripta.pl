#!/usr/bin/perl


$errorFlag=0;


while(<>){

	
	if(m/ERROR/){
		$errorFlag=1;

	}

	@row=split /\s+/, $_;
	
	if(@row[4] eq "Starting"){
		
		$starting++;

	}

	if(@row[4] eq "Finished"){
		
		$TCno++;
	
		if($errorFlag == 1){

			$errorFlag = 0;
			$counter++;
			print "$TCno.  @row[6]\n";
			
		}


	}


}


print "FAILED ==> $counter\n";
print "Starting -> $starting :: Finished-> $TCno\n";
