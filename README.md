# docker-jenkins-unity-pipeline

使用GameCi  
https://game.ci/

JENKINS_HOME UNITY_HOME 需自己设置在Jenkins中,路径为 宿主机 路径 \n 
比如 \n
JENKINS_HOME=/home/abc/docker/jenkins/jenkins_data  \n
UNITY_HOME=/home/abc/docker/unity/data  \n

SdkPath NdkPath JdkPath GradlePath 为空时，使用的unity默认的工具  
如需自定义,需要手动下载各种工具放在宿主机指定位置,示例写法为 
gradle-7.2 , sdk-unity2020-04  
这些路径下的文件会挂载到 unity docker 中  

ShGitPath ShGitBranch ShPath 是读取打包sh文件的Git仓库
