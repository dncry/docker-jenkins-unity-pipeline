# docker-jenkins-unity-pipeline

通过 **Ubuntu主机** 运行 **Docker-Jenkins**  
通过 **Docker-Jenkins** 运行 **Docker-Unity**

***

使用**GameCi**  
官网 <https://game.ci/>

***

**JENKINS_HOME UNITY_HOME** 需自己设置在Jenkins中,路径为 宿主机 路径  
比如  
JENKINS_HOME=`/home/abc/docker/jenkins/jenkins_data`  
UNITY_HOME=`/home/abc/docker/unity/data`  

***

**SdkPath NdkPath JdkPath GradlePath** 为空时，使用的unity默认的工具  
如需自定义,需要手动下载各种工具放在宿主机指定位置,示例写法为  
`gradle-7.2` , `sdk-unity2020-04`  
这些路径下的工具会挂载到 unity docker 中  

***

**ShGitPath ShGitBranch ShPath** 是读取打包sh文件的Git仓库  
sh文件就存放在此git仓库  
`/sh`


***

**个人版** UNITY_SERIAL    
`cat Unity_lic.ulf | grep DeveloperData | sed -E 's/.*Value="([^"]+)".*/\1/' | base64 --decode`

