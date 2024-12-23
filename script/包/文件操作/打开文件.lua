require "import"
import "android.widget.*"
import "android.view.*"
import "java.io.*"
import "android.content.*"

--目前不支持直接传递路径到app中,将路径传递到fv任务中再通过fv任务打开文件
local function 调用fv打开文件(路径)--传递内容到fv任务中
 --分享文字到fv任务
 text=路径
 intent=Intent(Intent.ACTION_SEND); 
 intent.setType("text/plain"); 
 intent.putExtra(Intent.EXTRA_SUBJECT, "分享"); 
 intent.putExtra(Intent.EXTRA_TEXT, text); 
 intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK); 
 componentName =ComponentName("com.fooview.android.fooview","com.fooview.android.fooview.FooWorkflowStarter");
 intent.setComponent(componentName)
 
 service.startActivity(Intent.createChooser(intent,"分享到:")); 
end

local function 发送广播(tab1,tab2)
  import "android.content.Intent"
  import "android.content.IntentFilter"
  import "android.content.BroadcastReceiver"
  when type(tab1)=="string" tab1={tab1}
  for k1,v1 in pairs(tab1)
    local intent= Intent(v1)
    for k,v in pairs(tab2)
      intent.putExtra(tostring(k), v)
    end
    service.sendBroadcast(intent)
  end
end


function 打开文件(路径)
   if pcall(function() service.getPackageManager().getPackageInfo("com.fooview.android.fooview",0) end) then
     发送广播( "com.fooview.android.fooview",{Open=路径})
   else
     service.editFile(路径)--用内置编辑器打开文件
   end
end

