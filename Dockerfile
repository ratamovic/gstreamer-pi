FROM resin/rpi-raspbian
ARG BRANCH=1.13.91
ENV LD_LIBRARY_PATH=/usr/local/lib/
WORKDIR /work

RUN apt-get update \
 && apt-get upgrade \
 && apt-get install -y --force-yes \
    build-essential autotools-dev automake autoconf \
    libtool autopoint libxml2-dev zlib1g-dev libglib2.0-dev \
    pkg-config bison flex python3 git gtk-doc-tools libasound2-dev \
    libgudev-1.0-dev libxt-dev libvorbis-dev libcdparanoia-dev \
    libpango1.0-dev libtheora-dev libvisual-0.4-dev iso-codes \
    libgtk-3-dev libraw1394-dev libiec61883-dev libavc1394-dev \
    libv4l-dev libcairo2-dev libcaca-dev libspeex-dev libpng-dev \
    libshout3-dev libjpeg-dev libaa1-dev libflac-dev libdv4-dev \
    libtag1-dev libwavpack-dev libpulse-dev libsoup2.4-dev libbz2-dev \
    libcdaudio-dev libdc1394-22-dev ladspa-sdk libass-dev \
    libcurl4-gnutls-dev libdca-dev libdirac-dev libdvdnav-dev \
    libexempi-dev libexif-dev libfaad-dev libgme-dev libgsm1-dev \
    libiptcdata0-dev libkate-dev libmimic-dev libmms-dev \
    libmodplug-dev libmpcdec-dev libofa0-dev libopus-dev \
    librsvg2-dev librtmp-dev libschroedinger-dev libslv2-dev \
    libsndfile1-dev libsoundtouch-dev libspandsp-dev libx11-dev \
    libxvidcore-dev libzbar-dev libzvbi-dev liba52-0.7.4-dev \
    libcdio-dev libdvdread-dev libmad0-dev libmp3lame-dev \
    libmpeg2-4-dev libopencore-amrnb-dev libopencore-amrwb-dev \
    libsidplay1-dev libtwolame-dev libx264-dev libusb-1.0 \
    mpg123 \
    python-gi-dev yasm python3-dev libgirepository1.0-dev \
    vim

RUN git clone https://github.com/GStreamer/gstreamer \
 && git clone https://github.com/GStreamer/gst-plugins-bad \
 && git clone https://github.com/GStreamer/gst-plugins-base \
 && git clone https://github.com/GStreamer/gst-plugins-good \
 && git clone https://github.com/GStreamer/gst-plugins-ugly \
 && git clone https://github.com/GStreamer/gst-libav \
 && git clone https://github.com/GStreamer/gst-omx \
 && git clone https://github.com/GStreamer/gst-python \
 && git clone https://github.com/GStreamer/gst-rtsp-server.git

RUN (cd gstreamer && git checkout $BRANCH && ./autogen.sh --disable-gtk-doc && make && make install) \
 && (cd gst-plugins-base && git checkout $BRANCH && ./autogen.sh --disable-gtk-doc && make && make install) \
 && (cd gst-plugins-good && git checkout $BRANCH && ./autogen.sh --disable-gtk-doc && make && make install) \
 && (cd gst-plugins-bad && git checkout $BRANCH && ./autogen.sh --disable-gtk-doc && make && make install) \
 && (cd gst-plugins-ugly && git checkout $BRANCH && ./autogen.sh --disable-gtk-doc && make && make install) \
 && (cd gst-libav && git checkout $BRANCH && ./autogen.sh --disable-gtk-doc && make && make install) \
 && (cd gst-omx && git checkout $BRANCH && ./autogen.sh --disable-gtk-doc && make && make install) \
 && (cd gst-python && git checkout $BRANCH && ./autogen.sh --disable-gtk-doc && make && make install) \
 && (cd gst-rtsp-server && git checkout $BRANCH && ./autogen.sh --disable-gtk-doc && make && make install)

