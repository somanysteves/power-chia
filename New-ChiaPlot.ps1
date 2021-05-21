param (
	[System.IO.DirectoryInfo] $Temp = "/mnt/plotterTemp",
	[System.IO.DirectoryInfo] $Destination = "/mnt/plots",
	[int] $Total = 1,
	[int] $Parallel = 1,
	[Timespan] $Stagger = 60s
)

Write-Warning "This script sucks."
#It assumes a lot of things that probably arent true

#It assumes:
#Youre power-chia repo and chia-blockchain repo are siblings
#Youre currently in the power-chia directory when you run this
#That your temp drive is /mnt/plotterTemp
#That your final destination is /mnt/plots
#and that you want 4 threads with 6gb of memory per parallel instance

#In short its awful and no one should use it. Why is it even here?
#Because.
#All code should go in source control, I want to share it with my plotter instances, and I don't feel like logging into github to do so with a private repo.

#So there you go, I'm sorry/you're welcome

pushd

try {
	cd ..
	cd chia-blockchain
	$jobs = 1..$Parallel | start-job {
		$debugPreference = "continue"
		write-debug "Started job $_ with stagger $using:stagger"
		start-sleep $([Timespan]::FromSeconds($using:stagger.TotalSeconds * $_)).TotalSeconds
		$start = Get-Date
		write-debug "actually starting job $_ at $start"
		& chia plots create `
			-n $([int]($using:Total / $using:Parallel)) `
			-t $using:Temp `
			-d $using:Destination `
			-r 4 -b 6000
		$end = (Get-Date) - $start
		write-debug "job $_ finished at $end"
		return $end
	}
	Receive-Job $jobs -Wait
}
finally {
	popd
}
