export PRJ_HOME="/mario/prj"

export PATH=.:$PRJ_HOME/unix-utils/scripts:/usr/local/bin/sage:$PRJ_HOME/unix-utils/tools/jmeter/bin:$PATH

alias goto=". $PRJ_HOME/unix-utils/scripts/goto.sh"
alias wizard="perl $PRJ_HOME/unix-utils/scripts/wizard.pl"

# CUDA settings

export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lib:/lib64:/usr/lib:/usr/lib64:/usr/local/cuda/lib64

export MARIO="MARIO"

echo "ALL SET"
