import { useEffect, useState } from "react";
import { FileWithPath, useDropzone } from "react-dropzone";
import File from "./File";

const DropZone = () => {
  const { acceptedFiles, isDragActive, getRootProps, getInputProps } =
    useDropzone();
  const [list, setList] = useState<Set<FileWithPath>>(new Set<FileWithPath>());

  useEffect(() => {
    const newList = new Set(list);
    acceptedFiles.forEach((file: FileWithPath) => newList.add(file));
    setList(newList);

    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [acceptedFiles]);

  const files = Array.from(list).map((file: FileWithPath, index) => (
    <File key={index} file={file} />
  ));

  return (
    <section className="dropzone-container">
      <div
        {...getRootProps({
          className: "dropzone" + (isDragActive ? " active" : ""),
        })}
      >
        <input {...getInputProps()} />
        <p>
          Upload images by dragging and dropping here, or selecting them by
          clicking here.
        </p>
      </div>
      <aside>{files}</aside>
    </section>
  );
};

export default DropZone;
