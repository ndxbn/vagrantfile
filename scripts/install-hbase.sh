# HBase は、Javaが必要
apt-get -y install java
VERSION=1.2.6

# HBase はパッケージが提供されていないので、マニュアルでインストール
curl http://ftp.riken.jp/net/apache/hbase/stable/hbase-${VERSION}-bin.tar.gz | tar zx
cd hbase-${VERSION}
rm -f CHANGES.txt LEGAL LICENSE.txt NOTICE.txt README.txt
cp -a * /usr/local
#
cd ..
rm -rf hbase-${VERSION}
cd ~

# HBase は、 "JAVA_HOME" 環境変数がないと、Javaを発見できない
echo "export JAVA_HOME=/usr" > /etc/profile.d/javahome.sh
