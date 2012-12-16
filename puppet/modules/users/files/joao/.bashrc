# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

echoIndicatorNow () {
echo -e "Symbol\tNow\t\t\tEntry\tCurrent Price";
fx-eval.pl --symbol=$1 --timeframe=15min "datetime,$2,close";
}

epl () {
echoIndicatorNow $1 "min(ema(close,200)+5*atr(14), 50)";
}

eps () { 
echoIndicatorNow $1 "max(ema(close,200)-5*atr(14), 50)";
}

cpl () {
echoIndicatorNow $1 "previous(min(low,240),1)";
}

cps () {
echoIndicatorNow $1 "previous(max(high,240),1)";
}

