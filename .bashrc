
#===============================================================
#
# ALIASES
#
#===============================================================

#---------
# GENERAL
#---------

#alias rm='rm -i'
#alias cp='cp -i'
#alias mv='mv -i'


alias h='history'
alias path='echo -e ${PATH//:/\\n}'
alias du='du -kh'
alias ..='cd ..'
alias less='less -+e -+E'



alias ll='ls -lrth --color=auto'
alias la='ls -al --color=auto'
alias lr='ls -lR --color=auto'



#--------
# SLURM
#--------

alias sc='scancel -u andreeve'
alias sb='sbatch'
alias sq='squeue -u andreeve'
#--------

alias sc='scancel -u andreeve'
alias sb='sbatch'
alias sq='squeue -u andreeve'
alias sc='scancel -u andreeve'
alias sb='sbatch'
alias sq='squeue -u andreeve'
alias slurm='nano /cluster/projects/nn9858k/slurmscript'
alias salloc='salloc --cpus-per-task=8 --mem-per-cpu=4G --time=08:00:00 --account=nn9858k'

#-------------
# DIRECTORIES
#-------------

alias ph='cd /cluster/projects/nn9858k/'
alias wrk='cd /cluster/work/users/andreeve'
alias ref='cd /cluster/projects/nn9858k/ref'



#-----------------
# MISSPELLING
#-----------------

alias kk='ls -lrth --color=auto'
alias mc='mv -i'


#----------
# CONDA
#----------

alias cb='conda activate /cluster/projects/nn9858k/conda'


#===============================================================
#
# FUNCTIONS
#
#===============================================================


# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'$*'*' -ls ; }
