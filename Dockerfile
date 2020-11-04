FROM python:3.8 
 
ARG WORKSPACE=/root 

RUN apt update && apt upgrade -y

Run apt install --no-install-recommends git cmake ninja-build gperf \
  ccache dfu-util device-tree-compiler wget \
  python3-dev python3-pip python3-setuptools python3-tk python3-wheel xz-utils file \
  make gcc gcc-multilib g++-multilib libsdl2-dev nodejs wget build-essential zsh  -y 

RUN pip3 install west && \
	echo 'export PATH=~/.local/bin:"$PATH"' >> ~/.bashrc  && \
	/bin/bash -c 'source  ~/.bashrc' && \
	west init ~/zephyrproject && \
	cd ~/zephyrproject && \
	west update && \
	west zephyr-export && \ 
	pip3 install --user -r ~/zephyrproject/zephyr/scripts/requirements.txt && \
	cd ~ && wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.11.4/zephyr-sdk-0.11.4-setup.run && \
	chmod +x zephyr-sdk-0.11.4-setup.run && \
	./zephyr-sdk-0.11.4-setup.run -- -d ~/zephyr-sdk-0.11.4

RUN git clone https://github.com/vim/vim.git && cd vim/src && ./configure &&  make && make install && \ 
	git config --global user.name "John Doe" && \
	git config --global user.email johndoe@example.com

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
 
WORKDIR $WORKSPACE

COPY .vimrc ${WORKSPACE}/.vimrc 
COPY plug.vim ${WORKSPACE}/.vim/autoload/plug.vim

RUN vim +PlugInstall +qall 

CMD ["zsh"]
