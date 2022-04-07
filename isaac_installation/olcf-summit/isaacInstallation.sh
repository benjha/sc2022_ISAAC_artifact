

ISAAC_BRANCH="isaac_new_alpaka"

source isaac.profile

# $MY_HOME is defined in isaac.profile
export SOURCE_DIR=$MY_HOME/isaac_sources
mkdir -p $SOURCE_DIR

#   iceT
if [ "$INSTALL_IceT" = true ] && [ ! -d $IceT_DIR ]; then
    git clone -b IceT-2.1.1 https://gitlab.kitware.com/icet/icet.git \
        $SOURCE_DIR/icet
    cd $SOURCE_DIR/icet
    mkdir .build
    cd .build
    cmake -DCMAKE_INSTALL_PREFIX=$IceT_DIR -DICET_USE_OPENGL=OFF \
        $SOURCE_DIR/icet
    make -j4 install
fi

#   jansson
if [ "$INSTALL_Jansson" = true ] && [ ! -d $Jansson_DIR ]; then
    git clone -b 2.11 https://github.com/akheron/jansson.git \
        $SOURCE_DIR/jansson
    cd $SOURCE_DIR/jansson
    mkdir .build
    cd .build
    cmake -DCMAKE_INSTALL_PREFIX=$Jansson_DIR \
        $SOURCE_DIR/jansson
    make -j4 install
fi

#   libwebsockets
if [ "$INSTALL_Libwebsockets" = true ] && [ ! -d $Libwebsockets_DIR ]; then
    git clone -b v4.0-stable https://github.com/warmcat/libwebsockets.git \
        $SOURCE_DIR/libwebsockets
    cd $SOURCE_DIR/libwebsockets
    mkdir .build
    cd .build
    cmake -DCMAKE_INSTALL_PREFIX=$Libwebsockets_DIR -DLWS_WITH_SSL=OFF \
        $SOURCE_DIR/libwebsockets
    make -j4 install
fi

#   libjpeg-turbo
if [ "$INSTALL_JPEG" = true ] && [ ! -d $JPEG_DIR ]; then
    git clone -b master https://github.com/libjpeg-turbo/libjpeg-turbo.git \
        $SOURCE_DIR/libjpeg-turbo
    cd $SOURCE_DIR/libjpeg-turbo
    mkdir .build
    cd .build
    cmake -DCMAKE_INSTALL_PREFIX=$JPEG_DIR \
        $SOURCE_DIR/libjpeg-turbo
    make -j4 install
fi

# glm
if [ "$INSTALL_GLM" = true ]; then
    git clone https://github.com/g-truc/glm.git \
	    $SOURCE_DIR/glm
    cd $SOURCE_DIR/glm
    git checkout 6ad79aae3eb5bf809c30bf1168171e9e55857e45
    cd $SOURCE_DIR/glm
    mkdir .build
    cd .build
    cmake -DCMAKE_INSTALL_PREFIX=$GLM_DIR -DGLM_TEST_ENABLE=OFF \
            $SOURCE_DIR/glm
    make -j4 install
fi

cd $HOME

# get ISAAC and install Server binary
if [ ! -d $ISAAC_DIR ]; then
    git clone -b $ISAAC_BRANCH https://github.com/benjha/isaac.git \
        $SOURCE_DIR/isaac
    cd $SOURCE_DIR/isaac
    mkdir .build
    cd .build
    cmake -DCMAKE_INSTALL_PREFIX=$ISAAC_DIR \
	$SOURCE_DIR/isaac/server
    make -j4 install
fi

