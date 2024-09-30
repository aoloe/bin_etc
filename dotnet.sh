if [ "${BASH_SOURCE[0]}" -ef "$0" ]
then
    echo "Usage: source $0"
    exit 1
fi

export PS1="dotnet> $PS1"
export DOTNET_ROOT=$HOME/bin/dotnet
export PATH=$PATH:$HOME/bin/dotnet
