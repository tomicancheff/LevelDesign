using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public enum CanvasType
{
    MainMenu,
    GameUI,
    PauseScreen,
    EndScreen
}

public class CanvasManager : Singleton<CanvasManager>
{
    private List<CanvasController> _canvasControllerList;
    private CanvasController _lastActiveCanvas;

    protected override void Awake()
    {
        base.Awake();
        _canvasControllerList = GetComponentsInChildren<CanvasController>().ToList();
        _canvasControllerList.ForEach(x=> x.gameObject.SetActive(false));
       SwitchCanvas(CanvasType.MainMenu);
    }

    public void SwitchCanvas(CanvasType desiredCanvasType)
    {
        if (_lastActiveCanvas != null)
        {
            _lastActiveCanvas.gameObject.SetActive(false);
        }
        var desiredCanvasController = _canvasControllerList.Find(x => x.canvasType == desiredCanvasType);
        if (desiredCanvasController != null)
        {
            desiredCanvasController.gameObject.SetActive(true);
            _lastActiveCanvas = desiredCanvasController;
        }
        else
            Debug.LogWarning("The desired canvas was not found");
        
    }
}
